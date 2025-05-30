unit Network.Android;

interface

uses
  NetWork.State;

type
  TPlatformNetworkState = class(TCustomNetworkState)
  public
{$IF Defined(ANDROID)}
    function CurrentSSID: string; override;
    function IsConnected: Boolean; override;
    function IsWifiConnected: Boolean; override;
    function IsMobileConnected: Boolean; override;
{$ENDIF}
  end;

implementation

{$IF Defined(ANDROID)}

uses
  System.SysUtils,
  Androidapi.JNIBridge,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Net,
  Androidapi.Helpers,
  FMX.Helpers.Android;
{$ENDIF}

{$IF Defined(ANDROID)}

function GetWifiManager: JWifiManager;
var
  WifiManagerNative: JObject;
begin
  WifiManagerNative := TAndroidHelper.Context.getSystemService(TJContext.JavaClass.WIFI_SERVICE);
  if not Assigned(WifiManagerNative) then
    raise Exception.Create('Could not locate Wifi Service');
  Result := TJWifiManager.Wrap((WifiManagerNative as ILocalObject).GetObjectID);
  if not Assigned(Result) then
    raise Exception.Create('Could not access Wifi Manager');
end;

function GetConnectivityManager: JConnectivityManager;
var
  ConnectivityServiceNative: JObject;
begin
  ConnectivityServiceNative := TAndroidHelper.Context.getSystemService(TJContext.JavaClass.CONNECTIVITY_SERVICE);
  if not Assigned(ConnectivityServiceNative) then
    raise Exception.Create('Could not locate Connectivity Service');
  Result := TJConnectivityManager.Wrap((ConnectivityServiceNative as ILocalObject).GetObjectID);
  if not Assigned(Result) then
    raise Exception.Create('Could not access Connectivity Manager');
end;

{ TPlatformNetworkState }

function TPlatformNetworkState.CurrentSSID: string;
var
  WifiManager: JWifiManager;
  Info: JWifiInfo;
begin
  Result := '';
  WifiManager := GetWifiManager;
  if Assigned(WifiManager) then
  begin
    Info := WifiManager.getConnectionInfo;
    if Assigned(Info) then
      Result := JStringToString(Info.getSSID);
  end;
end;

function TPlatformNetworkState.IsConnected: Boolean;
var
  ConnectivityManager: JConnectivityManager;
  ActiveNetwork: JNetworkInfo;
begin
  ConnectivityManager := GetConnectivityManager;
  ActiveNetwork := ConnectivityManager.getActiveNetworkInfo;
  Result := Assigned(ActiveNetwork) and ActiveNetwork.IsConnected;
end;

function TPlatformNetworkState.IsMobileConnected: Boolean;
var
  ConnectivityManager: JConnectivityManager;
  MobileNetwork: JNetworkInfo;
begin
  ConnectivityManager := GetConnectivityManager;
  MobileNetwork := ConnectivityManager.getNetworkInfo(TJConnectivityManager.JavaClass.TYPE_MOBILE);
  Result := MobileNetwork.IsConnected;
end;

function TPlatformNetworkState.IsWifiConnected: Boolean;
var
  ConnectivityManager: JConnectivityManager;
  WiFiNetwork: JNetworkInfo;
begin
  ConnectivityManager := GetConnectivityManager;
  WiFiNetwork := ConnectivityManager.getNetworkInfo(TJConnectivityManager.JavaClass.TYPE_WIFI);
  Result := WiFiNetwork.IsConnected;
end;
{$ENDIF}

end.
