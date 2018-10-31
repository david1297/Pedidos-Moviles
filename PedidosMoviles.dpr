program PedidosMoviles;

uses
  System.StartUpCopy,
  FMX.Forms,
  Principal in 'Principal.pas' {Main},
  datageneral in 'datageneral.pas' {DMGeneral: TDataModule},
  UClases in 'UClases.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TDMGeneral, DMGeneral);
  Application.Run;
end.
