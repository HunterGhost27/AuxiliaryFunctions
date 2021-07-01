//  ================
//  TYPE DEFINITIONS
//  ================

export interface AuxConfig {
    ProjectName: string,
    ProjectUUID: string,
    ScriptExtenderVersion: number,
    SEFeatureFlags: string[],
    ProjectDirectory: string
}

export interface AuxOptions {
    reinit: boolean,
}