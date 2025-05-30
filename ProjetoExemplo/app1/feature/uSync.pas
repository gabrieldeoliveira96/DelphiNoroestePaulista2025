unit uSync;

interface

procedure Sync;

var
 LSync:Boolean;

implementation

uses
  System.SysUtils, NetWork.State, System.Classes;

procedure Sync;
var
 LNet:TNetworkState;
begin
  LSync:= true;
  LNet := TNetworkState.Create;

  TThread.CreateAnonymousThread(
  procedure
  begin

    while true do
    begin
      sleep(1000);

      if not LNet.IsConnected then
        continue;

      if not LSync then
        break;
      //consulta banco local

      //envia para API

    end;
    FreeAndNil(LNet);

  end).Start;

end;

end.
