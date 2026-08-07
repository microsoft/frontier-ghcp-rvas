export type PermissionState =
  | "not-requested"
  | "granted"
  | "denied"
  | "blocked"
  | "unavailable";

export interface DevicePermissionGateway {
  requestCamera(): Promise<PermissionState>;
  requestLocation(): Promise<PermissionState>;
}

export class StarterPermissionGateway implements DevicePermissionGateway {
  async requestCamera(): Promise<PermissionState> {
    return "denied";
  }

  async requestLocation(): Promise<PermissionState> {
    return "denied";
  }
}

// Native Expo permission adapters and useful degraded modes are participant work.
export const permissionGateway = new StarterPermissionGateway();
