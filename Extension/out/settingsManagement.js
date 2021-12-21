"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.beginUpdateWorkspaceSettings = exports.getDebugCPaths = exports.getDebugPaths = exports.getLibraryPaths = void 0;
const vscode = require("vscode");
const utils = require("./utils");
function getLibraryPaths(context) {
    let lifeboatConfig = vscode.workspace.getConfiguration("lifeboatapi.stormworks.libs", utils.getCurrentWorkspaceFile());
    let lbPaths = [];
    let lifeboatLibraryPaths = lifeboatConfig.get("projectSpecificLibraryPaths") ?? [];
    let wslifeboatLibraryPaths = lifeboatConfig.get("workspaceLibraryPaths") ?? [];
    let userlifeboatLibraryPaths = lifeboatConfig.get("globalLibraryPaths") ?? [];
    for (let path of lifeboatLibraryPaths) {
        lbPaths.push(utils.sanitisePath(path));
    }
    for (let path of wslifeboatLibraryPaths) {
        lbPaths.push(utils.sanitisePath(path));
    }
    for (let path of userlifeboatLibraryPaths) {
        lbPaths.push(utils.sanitisePath(path));
    }
    // add lifeboatAPI to the library path
    if (utils.isMicrocontrollerProject()) {
        lbPaths.push(utils.sanitisePath(context.extensionPath) + "/assets/LifeBoatAPI/Microcontroller/");
        lbPaths.push(utils.sanitisePath(context.extensionPath) + "/assets/LifeBoatAPI/Tools/");
    }
    else {
        lbPaths.push(utils.sanitisePath(context.extensionPath) + "/assets/LifeBoatAPI/Addons/");
        lbPaths.push(utils.sanitisePath(context.extensionPath) + "/assets/LifeBoatAPI/Tools/");
    }
    return lbPaths;
}
exports.getLibraryPaths = getLibraryPaths;
function getDebugPaths(context) {
    let debugPaths = [
        utils.sanitisePath(context.extensionPath) + "/assets/luasocket/?.lua",
    ];
    for (let path of getLibraryPaths(context)) {
        debugPaths.push(path + "?.lua"); // irritating difference between how the debugger and the intellisense check paths
        debugPaths.push(path + "?.lbinternal"); // paths we want to be useable as lua, that we didn't want intellisense to see (ignore directories doesn't actually work)
    }
    return debugPaths;
}
exports.getDebugPaths = getDebugPaths;
function getDebugCPaths(context) {
    let luaDebugConfig = vscode.workspace.getConfiguration("lua.debug.settings");
    const defaultCPaths = [
        utils.sanitisePath(context.extensionPath) + "/assets/luasocket/dll/socket/core.dll",
        utils.sanitisePath(context.extensionPath) + "/assets/luasocket/dll/mime/core.dll"
    ];
    let existing = luaDebugConfig.get("cpath") ?? [];
    for (const cPathElement of defaultCPaths) {
        if (existing.indexOf(cPathElement) === -1) {
            existing.push(cPathElement);
        }
    }
    return existing;
}
exports.getDebugCPaths = getDebugCPaths;
function beginUpdateWorkspaceSettings(context) {
    let lifeboatConfig = vscode.workspace.getConfiguration("lifeboatapi.stormworks.libs", utils.getCurrentWorkspaceFile());
    let lifeboatLibraryPaths = getLibraryPaths(context);
    let lifeboatIgnorePaths = lifeboatConfig.get("ignorePaths") ?? [];
    // add standard ignores
    if (!lifeboatIgnorePaths.includes(".vscode")) {
        lifeboatIgnorePaths.push(".vscode");
    }
    if (!lifeboatIgnorePaths.includes("/out/")) {
        lifeboatIgnorePaths.push("/out/");
    }
    if (!lifeboatIgnorePaths.includes("/_build/")) {
        lifeboatIgnorePaths.push("/_build/");
    }
    let luaDiagnosticsConfig = vscode.workspace.getConfiguration("Lua.diagnostics");
    let luaRuntimeConfig = vscode.workspace.getConfiguration("Lua.runtime");
    let luaLibWorkspace = vscode.workspace.getConfiguration("Lua.workspace");
    let luaDebugConfig = vscode.workspace.getConfiguration("lua.debug.settings");
    let luaIntellisense = vscode.workspace.getConfiguration("Lua.IntelliSense");
    return Promise.resolve()
        .then(() => {
        if (!utils.getCurrentWorkspaceFolder()) {
            return Promise.reject("Can't update settings while no workspace is active");
        }
    }).then(() => {
        //Lua.diagnostics.disable
        let existing = luaLibWorkspace.get("disable") ?? [];
        if (existing.indexOf("lowercase-global") === -1) {
            existing.push("lowercase-global");
        }
        if (existing.indexOf("undefined-doc-name") === -1) {
            existing.push("undefined-doc-name");
        }
        return luaDiagnosticsConfig.update("disable", existing, vscode.ConfigurationTarget.Workspace);
    }).then(() => luaRuntimeConfig.update("version", "Lua 5.3", vscode.ConfigurationTarget.Workspace)).then(() => {
        //Lua.workspace.ignoreDir
        return luaLibWorkspace.update("ignoreDir", lifeboatIgnorePaths, vscode.ConfigurationTarget.Workspace);
    }).then(() => {
        // lua.debug.cpath
        return luaDebugConfig.update("cpath", getDebugCPaths(context), vscode.ConfigurationTarget.Workspace);
    }).then(() => {
        //lua.debug.path
        return luaDebugConfig.update("path", getDebugPaths(context), vscode.ConfigurationTarget.Workspace);
    }).then(() => {
        //Lua.workspace.library
        let docConfig = vscode.workspace.getConfiguration("lifeboatapi.stormworks.nelo", utils.getCurrentWorkspaceFile());
        // Nelo Docs root
        let neloAddonDoc = utils.sanitisePath(context.extensionPath) + "/assets/nelodocs/docs_missions.lua";
        let neloMCDoc = utils.sanitisePath(context.extensionPath) + "/assets/nelodocs/docs_vehicles.lua";
        if (docConfig.get("overwriteNeloDocsPath") === true) {
            neloAddonDoc = docConfig.get("neloAddonDocPath") ?? neloAddonDoc; // if the user screws it up, just use our bundled one
            neloMCDoc = docConfig.get("neloMicrocontrollerDocPath") ?? neloMCDoc;
        }
        lifeboatLibraryPaths.push(neloAddonDoc);
        lifeboatLibraryPaths.push(neloMCDoc);
        return luaLibWorkspace.update("library", lifeboatLibraryPaths, vscode.ConfigurationTarget.Workspace);
    }).then(() => luaDebugConfig.update("luaVersion", "5.3", vscode.ConfigurationTarget.Workspace))
        .then(() => luaDebugConfig.update("luaArch", "x86", vscode.ConfigurationTarget.Workspace))
        .then(() => luaIntellisense.update("traceBeSetted", true))
        .then(() => luaIntellisense.update("traceFieldInject", true))
        .then(() => luaIntellisense.update("traceLocalSet", true))
        .then(() => luaIntellisense.update("traceReturn", true));
}
exports.beginUpdateWorkspaceSettings = beginUpdateWorkspaceSettings;
//# sourceMappingURL=settingsManagement.js.map