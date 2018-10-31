unit datageneral;

interface

uses
  System.SysUtils, System.Classes, Data.DBXDataSnap, IPPeerClient,
  Data.DBXCommon, Data.DB, Data.SqlExpr, FMX.StdCtrls,  System.JSON, UClases;

type
  TDMGeneral = class(TDataModule)
  private
    { Private declarations }
  public
    vgUsuario, vgCliente: String;

    procedure ConectarServidor(IP: String; Puerto: Integer;
      Usuario, Password: String; SiConecta: TProc = nil;
      SiNoConecta: TProc = nil; SiValidaUser: TProc = nil;
      SiNoValidaUser: TProc = nil);
  end;

const
  cHostName_DUMMY = '142.4.202.90';

var
  DMGeneral: TDMGeneral;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{ %CLASSGROUP 'FMX.Controls.TControl' }

{$R *.dfm}

procedure TDMGeneral.ConectarServidor(IP: String; Puerto: Integer;
  Usuario, Password: String; SiConecta: TProc = nil; SiNoConecta: TProc = nil;
  SiValidaUser: TProc = nil; SiNoValidaUser: TProc = nil);
begin
  TThread.CreateAnonymousThread(
    procedure()
    begin
      try
        CNS_BASE_URI := Format(CNS_BASE_WS, [IP + ':' + Puerto.ToString]);

        if TJSONBool(TJSONArray(TRESTPeticion.GetContent(['ValidacionUsuario',
          Usuario, Password])).Items[0]).AsBoolean then
        begin
          TThread.Synchronize(TThread.CurrentThread,
            procedure()
            begin
              if Assigned(SiValidaUser) then
                SiValidaUser;
            end);

          TThread.Synchronize(TThread.CurrentThread,
            procedure()
            begin
              vgUsuario := Usuario;
              if Assigned(SiConecta) then
                SiConecta;
            end);

        end
        else
        begin
          TThread.Synchronize(TThread.CurrentThread,
            procedure()
            begin
              if Assigned(SiNoValidaUser) then
                SiNoValidaUser;
            end);
        end;

      except
          TThread.Synchronize(TThread.CurrentThread,
            procedure()
            begin
              if Assigned(SiNoConecta) then
                SiNoConecta;
            end);
      end
    end).Start;
end;

end.
