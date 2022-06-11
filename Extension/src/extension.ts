// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
import * as vscode from 'vscode';
import * as path from 'path';
import { Func } from 'mocha';
import { TextEncoder, promisify} from 'util';
import { settings } from 'cluster';
import * as utils from "./utils";
import * as projectCreation from "./projectCreation";
import * as settingsManagement from "./settingsManagement";
import * as runSimulator from "./runSimulator";
import * as runBuild from "./runBuild";
import * as handleGit from "./handleGit";
import { GistSetting } from './handleGit';
import { TerminalHandler } from './terminal';

// this method is called when your extension is activated
// the extension is activated the very first time the command is executed
export function activate(context: vscode.ExtensionContext)
{
	// track the folders we've loaded settings for - avoid rewriting settings constantly
	let loadedFolders : Set<vscode.WorkspaceFolder | undefined> = new Set<vscode.WorkspaceFolder | undefined>();

	vscode.window.onDidCloseTerminal(
		(t) => {
			TerminalHandler.get().onTerminalClosed(t);
		}, null, context.subscriptions);


	// when a lua file is created, if it's empty - add the boilerplate
	vscode.workspace.onDidOpenTextDocument(
		(document) => {
			if (utils.isStormworksProject() 
				&& document.languageId === "lua"
				&& document.lineCount === 1)
			{
				const boilerPlate = projectCreation.addBoilerplate("");
				let edit = new vscode.WorkspaceEdit();
				edit.insert(document.uri, new vscode.Position(0, 0), boilerPlate);
				return vscode.workspace.applyEdit(edit);
			}
			return false;
		}, null, context.subscriptions);

	vscode.workspace.onDidChangeTextDocument(
		(e) => {
			if(e.document && e.contentChanges.length > 0)
			{
				let relativePath = vscode.workspace.asRelativePath(e.document.uri);
				let libConfig = vscode.workspace.getConfiguration("lifeboatapi.stormworks.libs", e.document.uri);
                let existingGists : GistSetting[] = libConfig.get("sharedGistFiles") ?? [];
				for (let gist of existingGists)
				{
					if (gist.relativePath === relativePath)
					{
						gist.isDirty = true;
						libConfig.update("sharedGistFiles", existingGists);
						return;
					}
				}
			}
		}, null, context.subscriptions);

	// check if the settings need updated when the user swaps between editor windows
	vscode.window.onDidChangeActiveTextEditor(
		(e) => {
			let currentWorkspaceFolder = utils.getCurrentWorkspaceFolder();
			if (e
				&& currentWorkspaceFolder
				&& !loadedFolders.has(currentWorkspaceFolder)
				&& !e.document.fileName.includes("settings.json")
				&& !e.document.fileName.includes(".code-workspace")
				&& utils.isStormworksProject())
			{
				loadedFolders.add(currentWorkspaceFolder);
				return settingsManagement.updateLuaLibraryPaths(context, currentWorkspaceFolder);
			}
		}, null, context.subscriptions);

	// when the library paths are changed, this will have a knock-on to the other settings
	vscode.workspace.onDidChangeConfiguration(
		(e) => {
			if(e && e.affectsConfiguration("lifeboatapi.stormworks.libs.libraryPaths"))
			{
				loadedFolders.clear();
			}
		}, null, context.subscriptions);

	// COMMAND HANDLING --------------------------------------------------------------------------------
	// Simulate current file
	context.subscriptions.push(vscode.commands.registerCommand('lifeboatapi.simulate',
	() => {
		if(utils.isMicrocontrollerProject())
		{
			return utils.ensureBuildFolderExists().then(() => runSimulator.beginSimulator(context));
		}
	}));

	// Build current workspace
	context.subscriptions.push(vscode.commands.registerCommand('lifeboatapi.build',
	() => {
		if(utils.isStormworksProject())
		{
			return utils.ensureBuildFolderExists().then(() => runBuild.beginBuild(context));
		}
	}));

	// New MC
	context.subscriptions.push(vscode.commands.registerCommand('lifeboatapi.newMCProject',
	() =>{
		return projectCreation.beginCreateNewProjectFolder(context, true);
	}));
	
	// New Addon
	context.subscriptions.push(vscode.commands.registerCommand('lifeboatapi.newAddonProject',
	() =>{
		return projectCreation.beginCreateNewProjectFolder(context, false);
	}));

	// Share File Gist Link
	context.subscriptions.push(vscode.commands.registerCommand('lifeboatapi.shareFile',
	(file) => {
		return handleGit.shareSelectedFile(context, file);
	}));

	// Add Library
	context.subscriptions.push(vscode.commands.registerCommand('lifeboatapi.cloneGitLibrary',
	() => {
		return utils.ensureBuildFolderExists().then(() => handleGit.addLibraryFromURL(context));
	}));

	// Remove Library
	context.subscriptions.push(vscode.commands.registerCommand('lifeboatapi.removeLibrary',
	(file) => {
		return handleGit.removeSelectedLibrary(context, file);
	}));

	// Update Libraries
	context.subscriptions.push(vscode.commands.registerCommand('lifeboatapi.updateLibraries',
	() => {
		return utils.ensureBuildFolderExists().then(() => handleGit.updateLibraries(context));
	}));
}

// this method is called when your extension is deactivated
export function deactivate() {}

