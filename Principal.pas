unit Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, StrUtils, FMX.Graphics, FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.MultiView, FMX.TabControl, FMX.Edit,
  FMX.Effects, FMX.Ani, datageneral, Data.DB, Datasnap.DBClient, System.IOUtils,
  FMX.SearchBox,
  System.Actions, FMX.ActnList, Generics.Collections, System.JSON,
  Data.DBXJSONReflect, UClases, System.Threading,
  FMX.ListView.Types, Data.Bind.Components, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.ListView, Data.Bind.EngExt, FMX.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.DBScope, FMX.ListBox,
  FMX.Maps, FMX.Layouts, FMX.DateTimeCtrls, FMX.DialogService;

type
  TMain = class(TForm)
    TCPrincipal: TTabControl;
    TICliente: TTabItem;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    MvConfiguracion: TMultiView;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EdIP: TEdit;
    EdPuerto: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    EdUsuario: TEdit;
    Label7: TLabel;
    EdContra: TEdit;
    CPGeneral: TCalloutPanel;
    FAGeneral: TFloatAnimation;
    LGMensaje: TLabel;
    ShadowEffect1: TShadowEffect;
    Conectar: TButton;
    AAutenticando: TAniIndicator;
    CDAutenticacion: TClientDataSet;
    CDAutenticacionIp: TStringField;
    CDAutenticacionPuerto: TStringField;
    CDAutenticacionUsuario: TStringField;
    CDAutenticacionPassword: TStringField;
    SBTerceros: TSearchBox;
    CDSTercero: TClientDataSet;
    CDSTerceroID_N: TStringField;
    CDSTerceroCOMPANY: TStringField;
    CDSTerceroNIT: TStringField;
    CDSTerceroPHONE1: TStringField;
    CDSTerceroCONTACT1: TStringField;
    CDSTerceroCITY: TStringField;
    CDSTerceroDEPARTAMENTO: TStringField;
    CDSTerceroPAIS: TStringField;
    CDSTerceroADDR1: TStringField;
    CDSTerceroCREDITLMT: TFloatField;
    CPCargando: TCalloutPanel;
    AIPpalCargando: TAniIndicator;
    lblNohayTerceros: TLabel;
    ListView1: TListView;
    BindSourceDB1: TBindSourceDB;
    TIInformacion_Cliente: TTabItem;
    ToolBar2: TToolBar;
    SpeedButton2: TSpeedButton;
    Label8: TLabel;
    EdNit: TEdit;
    Panel3: TPanel;
    LNombre_Cliente: TLabel;
    Label10: TLabel;
    CBTelefonos: TComboBox;
    CBShipto: TComboBox;
    Label11: TLabel;
    pnlTotalCartera: TPanel;
    Layout1: TLayout;
    btDisponible: TButton;
    Layout2: TLayout;
    Layout3: TLayout;
    Label9: TLabel;
    LTDisponible: TLabel;
    Label14: TLabel;
    LTCupo: TLabel;
    Label15: TLabel;
    LTCartera: TLabel;
    lblNoTieneCartera: TLabel;
    TIPedido: TTabItem;
    CDSShipto: TClientDataSet;
    CDSShiptoSUCCLIENTE: TIntegerField;
    CDSShiptoCOMPANY: TStringField;
    BindSourceDB2: TBindSourceDB;
    LVCartera: TListView;
    Label12: TLabel;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    LinkListControlToField2: TLinkListControlToField;
    SpeedButton3: TSpeedButton;
    Panel4: TPanel;
    EdNitPedido: TEdit;
    Label13: TLabel;
    LNombre_ClientePedido: TLabel;
    Label17: TLabel;
    BtTelefono: TComboBox;
    cbShiptoDetPed: TComboBox;
    Label18: TLabel;
    Label16: TLabel;
    Label19: TLabel;
    DateEdit1: TDateEdit;
    Edit1: TEdit;
    Panel5: TPanel;
    Label20: TLabel;
    SpeedButton4: TSpeedButton;
    LbTotalPedido: TLabel;
    ToolBar3: TToolBar;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    TIBucar_Item: TTabItem;
    ToolBar4: TToolBar;
    SpeedButton7: TSpeedButton;
    TCBusquedaItems: TTabControl;
    TIBusquedaItems: TTabItem;
    SBItems: TSearchBox;
    TIDisponibilidadItem: TTabItem;
    LVDisponibilidadItem: TListView;
    lblNoExistencias: TLabel;
    lblItemSeleccionado: TLabel;
    CDSItems: TClientDataSet;
    CDSItemsDESCRIPCION: TStringField;
    CDSItemsPRICE: TFloatField;
    CDSItemsITEM: TStringField;
    CDSItemsMAN_LOTE: TStringField;
    CDSItemsPRICE_SIN_DESC: TFloatField;
    CDSItemsRATE: TFloatField;
    LVItems: TListView;
    CDSItemsCantidad: TStringField;
    BindSourceDB3: TBindSourceDB;
    LinkListControlToField3: TLinkListControlToField;
    Label22: TLabel;
    SpeedButton8: TSpeedButton;
    Label23: TLabel;
    Label24: TLabel;
    TAPedido: TTabControl;
    TIDetalleItem: TTabItem;
    TIPedidoItems: TTabItem;
    ListBox1: TListBox;
    Label26: TLabel;
    Label27: TLabel;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxItem6: TListBoxItem;
    ListBoxItem7: TListBoxItem;
    ListBoxGroupHeader2: TListBoxGroupHeader;
    ListBoxItem8: TListBoxItem;
    EdCantidad: TEdit;
    EdvlrUnitario: TEdit;
    EdTSIva: TEdit;
    EdTCIva: TEdit;
    EdITotal: TEdit;
    EdIva: TEdit;
    EdTotal: TEdit;
    EdBodega: TEdit;
    Panel6: TPanel;
    SpeedButton9: TSpeedButton;
    CDSPedidoD: TClientDataSet;
    CDSPedidoDPOSICION: TIntegerField;
    CDSPedidoDLOC: TStringField;
    CDSPedidoDITEM: TStringField;
    CDSPedidoDDESCRIPCION: TStringField;
    CDSPedidoDPRICE: TFloatField;
    CDSPedidoDRATE: TFloatField;
    CDSPedidoDCANTIDAD: TFloatField;
    CDSPedidoDSUBTOTAL: TFloatField;
    CDSPedidoDTOTAL: TFloatField;
    CDSPedidoDPRECIO_STR: TStringField;
    CDSPedidoDSUBTOTAL_STR: TStringField;
    CDSPedidoDIVA_STR: TStringField;
    CDSPedidoDTOTAL_STR: TStringField;
    CDSPedidoDNOTES: TStringField;
    CDSPedidoDPRICE_SIN_DESC: TFloatField;
    BindSourceDB4: TBindSourceDB;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    LinkControlToField6: TLinkControlToField;
    LinkPropertyToFieldText: TLinkPropertyToField;
    LinkFillControlToField: TLinkFillControlToField;
    ListView2: TListView;
    LinkListControlToField4: TLinkListControlToField;
    procedure ConectarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FAGeneralFinish(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SBTercerosKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure SpeedButton2Click(Sender: TObject);
    procedure btDisponibleClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SBItemsKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure lvListaProductosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure LVItemsItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure SpeedButton7Click(Sender: TObject);
    procedure LVDisponibilidadItemItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure SpeedButton6Click(Sender: TObject);
    procedure CDSPedidoDAfterPost(DataSet: TDataSet);
    procedure CDSPedidoDCANTIDADChange(Sender: TField);
    procedure CDSPedidoDNewRecord(DataSet: TDataSet);
    procedure CDSPedidoDCalcFields(DataSet: TDataSet);
    procedure SpeedButton9Click(Sender: TObject);
    procedure ListView2ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure EstablecerMensaje(Msj: String; Color: TAlphaColor = 0);
    procedure EstadoConectando(Conectando: Boolean);
    procedure ConexionBasica;
    procedure ValidaYEjecuta(Proc: TProc; out pITask: ITask);
    function FormatearTelefono(Telefono: String): String;
    procedure CreaCarteraList(pCartera: TCartera);
    procedure PutCantidadItem(pValue: TListViewItem);
    procedure CreaEncabezadoListDisp(pDescBodega: String);
    procedure CreaItemListDisponibilidad(pItem: TItem; pBodega, pLote: String;
      pCantidad: Double; pFechaLote: TDate);
    procedure CancelarTasks;
    procedure CalcularTotales; overload;

  const
    cFormatoPesos = '$ ###,###,###';
    cFormatoNumerico = '###,###,###';
    cInicializacionNumerica = '$ 0';
    cFormatoPorcentaje = '% ###,###,##0.00';
    MSG_ReviseConexionInternet =
      'Revise su conexión a Internet y los datos del Servidor';
    MSG_ConexionExitosa = 'Conexión Establecida con Exito';
    MSG_UserPassNoValido = 'Usuario y/o Contraseña no Validos';
    MSG_EscribirIP = 'Debe escribir al menos una IP';
    MSG_PEDIDO_GUARDADO = 'Pedido enviado';
    MSG_ERROR_PEDIDO = 'Hubo un ERROR al enviar el pedido';
    MSG_PEDIDO_AUTORIZADO = 'El pedido ya está autorizado';

  var
    vValidacionCorrecta: Boolean;
    vRutaDocumentos: String;
    vlMonitor: TObject;
    vAltolyDisponibilidad: Double;
    vListaItem: TObjectList<TItem>;
    vTasks: TArray<ITask>;
    OnEventoErrorConexion: TNotifyEvent;
  end;

var
  Main: TMain;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.Windows.fmx MSWINDOWS}

{ TForm1 }

procedure TMain.btDisponibleClick(Sender: TObject);
var
  vCartera: TCartera;
  vCurrentTipo: String;
  vTotalCartera: Double;
  vListViewCartera: TListViewItem;
  vListaCar: TObjectList<TCartera>;
  vUM: TJSONUnMarshal;
begin

  vUM := TJSONUnMarshal.Create;
  vListaCar := TObjectList<TCartera>.Create;
  try
    vListaCar := TObjectList<TCartera>
      (vUM.Unmarshal(TJSONArray(TRESTPeticion.GetContent(['TraeListaCartera',
      CDSTerceroID_N.AsString])).Items[0]));
    LVCartera.BeginUpdate;
    LVCartera.Items.Clear;

    vTotalCartera := 0;
    vCurrentTipo := EmptyStr;

    for vCartera in vListaCar do
    begin
      if vCurrentTipo <> vCartera.TIPO then
      begin
        vListViewCartera := LVCartera.Items.Add;
        vListViewCartera.Purpose := TListItemPurpose.Header;
        vListViewCartera.Text := 'Tipo: ' + vCartera.TIPO;
        vCurrentTipo := vCartera.TIPO;
      end;
      CreaCarteraList(vCartera);
      vTotalCartera := vTotalCartera + vCartera.SALDO;
    end;

    LTCartera.Text := FormatFloat(cFormatoPesos, vTotalCartera);
    LTDisponible.Text := FormatFloat(cFormatoPesos, CDSTerceroCREDITLMT.AsFloat
      - vTotalCartera);

    if ((CDSTerceroCREDITLMT.AsFloat - vTotalCartera) < 0) then
      LTDisponible.FontColor := TAlphaColorRec.Red
    else
      LTDisponible.FontColor := TAlphaColorRec.Blue;

    lblNoTieneCartera.Visible := (vTotalCartera = 0);
  finally
    LVCartera.EndUpdate;

    if btDisponible.Text = '↓↓↓' then
    begin
      pnlTotalCartera.AnimateFloat('Height',
        (pnlTotalCartera.Height - vAltolyDisponibilidad), 1,
        TAnimationType.InOut, TInterpolationType.Elastic);
      btDisponible.Text := '↑↑↑';
    end
    else
    begin
      pnlTotalCartera.AnimateFloat('Height',
        (pnlTotalCartera.Height + vAltolyDisponibilidad), 1,
        TAnimationType.InOut, TInterpolationType.Elastic);
      btDisponible.Text := '↓↓↓';
    end;
  end;
end;

procedure TMain.CalcularTotales;
var
  vBookMark: TBookMark;
  vTotal, vIVA: Extended;
begin
  vBookMark := CDSPedidoD.GetBookmark;
  // CDSPedidoD.DisableControls;
  try
    vTotal := 0;
    vIVA := 0;
    CDSPedidoD.First;
    while not CDSPedidoD.Eof do
    begin
      vTotal := vTotal +
        CDSPedidoDTOTAL.
        AsFloat { ((CDSPedidoDPRICE_SIN_DESC.AsFloat * CDSPedidoDCANTIDAD.AsFloat)) };
      vIVA := vIVA +
        ((CDSPedidoDPRICE_SIN_DESC.AsFloat * CDSPedidoDCANTIDAD.AsFloat) *
        (CDSPedidoDRATE.AsFloat / 100));
      CDSPedidoD.Next;
    end;

    LbTotalPedido.Text := FormatFloat(cFormatoPesos, vTotal);
    EdTotal.Text := FormatFloat(cFormatoPesos, vTotal);
    EdIva.Text := FormatFloat(cFormatoPesos, vIVA);
  finally
    CDSPedidoD.GotoBookmark(vBookMark);
    CDSPedidoD.FreeBookmark(vBookMark);
    // CDSPedidoD.EnableControls;
  end;
end;

procedure TMain.CancelarTasks;
var
  vTask: ITask;
begin
  if Length(vTasks) <> 0 then
  begin
    for vTask in vTasks do
      vTask.Cancel;
    SetLength(vTasks, 0);
  end;
end;

procedure TMain.CDSPedidoDAfterPost(DataSet: TDataSet);
begin
  CalcularTotales;
end;

procedure TMain.CDSPedidoDCalcFields(DataSet: TDataSet);
begin
CDSPedidoDPRECIO_STR.AsString := 'Cantidad: ' + FormatFloat(cFormatoNumerico, CDSPedidoDCANTIDAD.AsFloat) +
    ' - Precio: ' + FormatFloat(cFormatoPesos, CDSPedidoDPRICE.AsFloat);
  CDSPedidoDIVA_STR.AsString := 'SubTotal: ' + FormatFloat(cFormatoPesos, CDSPedidoDSUBTOTAL.AsFloat) + ' - Iva: ' +
    FormatFloat(cFormatoPorcentaje, CDSPedidoDRATE.AsFloat);
  CDSPedidoDTOTAL_STR.AsString := 'Total: ' + FormatFloat(cFormatoPesos, CDSPedidoDTOTAL.AsFloat);
end;

procedure TMain.CDSPedidoDCANTIDADChange(Sender: TField);
begin

  CDSPedidoDSUBTOTAL.AsFloat :=
    (CDSPedidoDPRICE.AsFloat * CDSPedidoDCANTIDAD.AsFloat);
  CDSPedidoDTOTAL.AsFloat := (CDSPedidoDSUBTOTAL.AsFloat) +
    ((CDSPedidoDPRICE.AsFloat * CDSPedidoDCANTIDAD.AsFloat) *
    (CDSPedidoDRATE.AsFloat / 100));
end;

procedure TMain.CDSPedidoDNewRecord(DataSet: TDataSet);
begin
CDSPedidoDPOSICION.AsInteger := CDSPedidoD.RecordCount + 1;
end;

procedure TMain.ConectarClick(Sender: TObject);
begin
  vValidacionCorrecta := False;
  EstadoConectando(True);
  if ((Trim(EdIP.Text) = EmptyStr)) then
  begin
    EstablecerMensaje(MSG_EscribirIP, TAlphaColorRec.Red);
    EstadoConectando(False);
  end
  else
    DMGeneral.ConectarServidor(EdIP.Text, StrToIntDef(EdPuerto.Text, 56044),
      EdUsuario.Text, EdContra.Text, nil,
      procedure()
      begin
        EstablecerMensaje(MSG_ReviseConexionInternet);
        EstadoConectando(False);
      end,
      procedure()
      begin
        EstadoConectando(False);
        vValidacionCorrecta := True;
        EstablecerMensaje(MSG_ConexionExitosa);
        CDAutenticacion.Edit;
        CDAutenticacionIp.AsString := EdIP.Text;
        CDAutenticacionPuerto.AsString := EdPuerto.Text;
        CDAutenticacionUsuario.AsString := EdUsuario.Text;
        CDAutenticacionPassword.AsString := EdContra.Text;
        CDAutenticacion.Post;
        CDAutenticacion.SaveToFile(vRutaDocumentos + 'LogPedidos.xml');
        MvConfiguracion.HideMaster;
        MvConfiguracion.Mode := TMultiViewMode.Drawer;
      end,
      procedure()
      begin
        EstablecerMensaje(MSG_UserPassNoValido);
        EstadoConectando(False);
      end);
end;

procedure TMain.ConexionBasica;
begin
  DMGeneral.ConectarServidor(CDAutenticacionIp.AsString,
    StrToIntDef(CDAutenticacionPuerto.AsString, 56044),
    CDAutenticacionUsuario.AsString, CDAutenticacionPassword.AsString,
    procedure()
    begin
      vValidacionCorrecta := True;
    end,
    procedure()
    begin
      vValidacionCorrecta := False;
      EstablecerMensaje(MSG_ReviseConexionInternet);
    end);
end;

procedure TMain.CreaCarteraList(pCartera: TCartera);
var
  vCartera: TListViewItem;
begin
  vCartera := LVCartera.Items.Add;
  vCartera.CreateObjects;
  vCartera.TagObject := pCartera;

  TListItemText(vCartera.View.FindDrawable('Numero')).Text := 'Numero: ' +
    pCartera.BATCH.ToString;
  TListItemText(vCartera.View.FindDrawable('Saldo')).Text := 'Saldo: ' +
    FormatFloat('###,###,##0.00', pCartera.SALDO);
  TListItemText(vCartera.View.FindDrawable('DiasVencimiento')).Text :=
    'Dias Vencimiento: ' + pCartera.DIAS_VENCIMIENTO.ToString;
  TListItemText(vCartera.View.FindDrawable('FechaFactura')).Text := 'Factura: '
    + DateToStr(pCartera.FECHA) + '- Vencimiento: ' +
    DateToStr(pCartera.DUEDATE);

end;

procedure TMain.CreaEncabezadoListDisp(pDescBodega: String);
var
  vItem: TListViewItem;
begin
  vItem := LVDisponibilidadItem.Items.Add;
  vItem.Purpose := TListItemPurpose.Header;
  vItem.Text := 'Bodega: ' + pDescBodega;
end;

procedure TMain.CreaItemListDisponibilidad(pItem: TItem; pBodega, pLote: String;
pCantidad: Double; pFechaLote: TDate);
var
  vItem: TListViewItem;
begin
  vItem := LVDisponibilidadItem.Items.Add;
  vItem.CreateObjects;
  vItem.TagObject := CDSItems;
  vItem.TagString := pBodega;

  if CDSItemsMAN_LOTE.AsString = 'S' then
    TListItemText(vItem.View.FindDrawable('Lote')).Text := 'Lote: ' + pLote +
      ' - Ven. ' + FormatDateTime('MM/DD/YY', pFechaLote)
  else
    TListItemText(vItem.View.FindDrawable('Lote')).Text := 'Sin Lote';

  TListItemText(vItem.View.FindDrawable('Cantidad')).Text := 'Cantidad: ' +
    FormatFloat('###,###,##0', pCantidad);
end;

procedure TMain.EstablecerMensaje(Msj: String; Color: TAlphaColor);
begin
  if Msj = MSG_ReviseConexionInternet then
    MvConfiguracion.ShowMaster;

  CPGeneral.Visible := True;
  CPGeneral.BringToFront;
  CPGeneral.Height := 40;
  if Length(Msj) > 40 then
    CPGeneral.Height := CPGeneral.Height * (Length(Msj) / 40);

  LGMensaje.Text := Msj;

  if Color <> 0 then
    LGMensaje.TextSettings.FontColor := Color;

  FAGeneral.Start;
end;

procedure TMain.EstadoConectando(Conectando: Boolean);
begin
  AAutenticando.Enabled := Conectando;
  AAutenticando.Visible := Conectando;
  AAutenticando.Enabled := not Conectando;
end;

procedure TMain.FAGeneralFinish(Sender: TObject);
begin
  FAGeneral.Inverse := not FAGeneral.Inverse;
  CPGeneral.Visible := False;
end;

function TMain.FormatearTelefono(Telefono: String): String;
begin
  if Length(Trim(Telefono)) = 7 then
    Result := '032' + Trim(Telefono)
  else
    Result := Trim(Telefono);
end;

procedure TMain.FormCreate(Sender: TObject);
begin
  CDAutenticacion.Close;
  CDAutenticacion.CreateDataSet;
  CDAutenticacion.Open;
  CDSTercero.Close;
  CDSTercero.CreateDataSet;
  CDSTercero.Open;
  CDSShipto.Close;
  CDSShipto.CreateDataSet;
  CDSShipto.Open;
  CDSItems.Close;
  CDSItems.CreateDataSet;
  CDSItems.Open;
  CDSPedidoD.Close;
  CDSPedidoD.CreateDataSet;
  CDSPedidoD.Open;
  TCPrincipal.ActiveTab := TICliente;
  SBTerceros.SetFocus;



  vRutaDocumentos := IncludeTrailingPathDelimiter
    (System.IOUtils.TPath.GetDocumentsPath);

  MvConfiguracion.Mode := TMultiViewMode.Drawer;
  vValidacionCorrecta := False;
  if FileExists(vRutaDocumentos + 'LogPedidos.xml') then
  begin
    CDAutenticacion.LoadFromFile(vRutaDocumentos + 'LogPedidos.xml');
    EdIP.Text := CDAutenticacionIp.AsString;
    EdPuerto.Text := CDAutenticacionPuerto.AsString;
    EdUsuario.Text := CDAutenticacionUsuario.AsString;
    EdContra.Text := CDAutenticacionPassword.AsString;
  end
  else
    MvConfiguracion.ShowMaster;
  TCPrincipal.ActiveTab := TICliente;
  vAltolyDisponibilidad := Layout2.Height + Layout3.Height;
end;

procedure TMain.FormShow(Sender: TObject);
begin
  ConectarClick(Conectar);
end;

procedure TMain.ListView1ItemClick(const Sender: TObject;
const AItem: TListViewItem);
var
  vUM: TJSONUnMarshal;
  vListaShi: TObjectList<TShipto>;
  vShipto: TShipto;
  vCartera: TCartera;
  vCurrentTipo: String;
  vTotalCartera: Double;
  vListViewCartera: TListViewItem;
  vListaCar: TObjectList<TCartera>;
begin
  btDisponible.Text := '↑↑↑';
  pnlTotalCartera.Height := 48;

  TCPrincipal.ActiveTab := TIInformacion_Cliente;
  EdNit.Text := Trim(CDSTerceroNIT.AsString);
  DMGeneral.vgCliente := Trim(CDSTerceroID_N.AsString);
  // LNombre_Cliente.Text := CDSTerceroCOMPANY.AsString; busqueda de pedidos

  LTDisponible.Text := cInicializacionNumerica;
  LTCupo.Text := cInicializacionNumerica;
  LTCartera.Text := cInicializacionNumerica;
  lblNoTieneCartera.Visible := False;

  vUM := TJSONUnMarshal.Create;
  vListaShi := TObjectList<TShipto>.Create;
  try
    vListaShi := TObjectList<TShipto>
      (vUM.Unmarshal(TJSONArray(TRESTPeticion.GetContent(['TraeListaShipto',
      DMGeneral.vgCliente])).Items[0]));

    CBTelefonos.Items.Clear;

    if FormatearTelefono(vListaShi.First.PHONE1) <> EmptyStr then
      CBTelefonos.Items.Add(FormatearTelefono(vListaShi.First.PHONE1));

    if FormatearTelefono(vListaShi.First.PHONE2) <> EmptyStr then
      CBTelefonos.Items.Add(FormatearTelefono(vListaShi.First.PHONE2));

    if FormatearTelefono(vListaShi.First.PHONE3) <> EmptyStr then
      CBTelefonos.Items.Add(FormatearTelefono(vListaShi.First.PHONE3));

    CBTelefonos.ItemIndex := 0;
    BtTelefono.Items := CBTelefonos.Items;
    BtTelefono.ItemIndex := 0;

    CDSShipto.EmptyDataSet;
    CDSShipto.Close;
    CDSShipto.Open;

    for vShipto in vListaShi do
    begin
      CDSShipto.Append;
      CDSShiptoSUCCLIENTE.AsInteger := vShipto.SUCCLIENTE;
      CDSShiptoCOMPANY.AsString := vShipto.COMPANY;
      CDSShipto.Post;
    end;
    CDSShipto.First;

    EdNitPedido.Text := EdNit.Text;
    cbShiptoDetPed.Items := CBShipto.Items;
    cbShiptoDetPed.ItemIndex := 0;
    LNombre_Cliente.Text := CDSTerceroCOMPANY.AsString;
    LNombre_ClientePedido.Text := Trim(CDSTerceroCOMPANY.AsString);
    LTCupo.Text := FormatFloat(cFormatoPesos, CDSTerceroCREDITLMT.AsFloat);
  finally
    vUM.DisposeOf;
    vListaShi.DisposeOf;
  end;
  LVCartera.Items.Clear;
  btDisponibleClick(btDisponible);

end;

procedure TMain.ListView2ItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
 CDSPedidoD.Locate('POSICION', TControl(Sender).Tag, []);
  CDSPedidoD.Edit;
  TAPedido.ActiveTab := TIDetalleItem;
  edCantidad.SetFocus;
  edCantidad.SelectAll;
end;

procedure TMain.LVDisponibilidadItemItemClick(const Sender: TObject;
const AItem: TListViewItem);
var
  vItem: TItem;
begin
  vItem := TItem(AItem.TagObject);

  // *** Acá va el llenado del registro seleccionado...
  if CDSPedidoD.Locate('ITEM', Trim(CDSItemsITEM.AsString), []) then
    CDSPedidoD.Edit
  else
    CDSPedidoD.Append;

  CDSPedidoDITEM.AsString := CDSItemsITEM.AsString;
  CDSPedidoDPRICE.AsFloat := CDSItemsPRICE.AsFloat;
  CDSPedidoDPRICE_SIN_DESC.AsFloat := CDSItemsPRICE_SIN_DESC.AsFloat;
  CDSPedidoDRATE.AsFloat := CDSItemsRATE.AsFloat;
  CDSPedidoDCANTIDAD.AsFloat := 1;
  CDSPedidoDLOC.AsString := AItem.TagString;
  CDSPedidoDSUBTOTAL.AsFloat :=
    (CDSPedidoDPRICE.AsFloat * CDSPedidoDCANTIDAD.AsFloat);
  CDSPedidoDTOTAL.AsFloat := (CDSPedidoDSUBTOTAL.AsFloat) +
    ((CDSPedidoDPRICE.AsFloat * CDSPedidoDCANTIDAD.AsFloat) *
    (CDSPedidoDRATE.AsFloat / 100));
  CDSPedidoDDESCRIPCION.AsString := CDSItemsDESCRIPCION.AsString;


  TCPrincipal.ActiveTab := TIPedido;
  TAPedido.ActiveTab := TIDetalleItem;

  EdCantidad.SetFocus;
  EdCantidad.SelectAll;
end;

procedure TMain.LVItemsItemClick(const Sender: TObject;
const AItem: TListViewItem);

var
  // vItem: TItem;
  vUM: TJSONUnMarshal;
  vCodigoCurrentBodega: String;
  vListaBodega: TObjectList<TBodega>;
  vBodega: TBodega;
  vItem: TListViewItem;
begin

  LVDisponibilidadItem.Items.Clear;

  vUM := TJSONUnMarshal.Create;
  vListaBodega := TObjectList<TBodega>.Create;
  try
    try
      vListaBodega := TObjectList<TBodega>
        (vUM.Unmarshal(TJSONArray(TRESTPeticion.GetContent(['TraeListaBodega',
        CDSItemsITEM.AsString])).Items[0]));

      vCodigoCurrentBodega := EmptyStr;
      for vBodega in vListaBodega do
      begin
        if vCodigoCurrentBodega <> vBodega.LOCATION then
        begin
          vCodigoCurrentBodega := vBodega.LOCATION;
          CreaEncabezadoListDisp(vBodega.DES_LOC);
        end;
        vItem := LVDisponibilidadItem.Items.Add;
        vItem.CreateObjects;
        vItem.TagObject := CDSItems;
        vItem.TagString := vBodega.LOCATION;

        if CDSItemsMAN_LOTE.AsString = 'S' then
          TListItemText(vItem.View.FindDrawable('Lote')).Text := 'Lote: ' +
            vBodega.LOTE + ' - Ven. ' + FormatDateTime('MM/DD/YY',
            vBodega.LOTEFVENCE)
        else
          TListItemText(vItem.View.FindDrawable('Lote')).Text := 'Sin Lote';

        TListItemText(vItem.View.FindDrawable('Cantidad')).Text := 'Cantidad: '
          + FormatFloat('###,###,##0', vBodega.CANTIDAD.ToDouble);

        // CreaItemListDisponibilidad(vItem, vBodega.LOCATION, vBodega.LOTE,
        // vBodega.CANTIDAD.ToDouble, vBodega.LOTEFVENCE);
      end;
    except
      if Assigned(OnEventoErrorConexion) then
        OnEventoErrorConexion(Sender);
    end;
  finally

    lblItemSeleccionado.BeginUpdate;
    lblItemSeleccionado.Text := CDSItemsDESCRIPCION.AsString;
    lblNoExistencias.Visible := (vListaBodega.Count = 0);
    lblItemSeleccionado.EndUpdate;
    // lblItemSeleccionado.Repaint;
    vUM.DisposeOf;
    vListaBodega.DisposeOf;

  end;

  TCBusquedaItems.ActiveTab := TIDisponibilidadItem;
end;

procedure TMain.lvListaProductosItemClick(const Sender: TObject;
const AItem: TListViewItem);
var
  vItem: TItem;
  vUM: TJSONUnMarshal;
  vCodigoCurrentBodega: String;
  vListaBodega: TObjectList<TBodega>;
begin

  vItem := vListaItem.Items[AItem.Index - ((AItem.Index div 2) + 1)];
  LVDisponibilidadItem.Items.Clear;

  vUM := TJSONUnMarshal.Create;
  vListaBodega := TObjectList<TBodega>.Create;
  try
    try
      vListaBodega := TObjectList<TBodega>
        (vUM.Unmarshal(TJSONArray(TRESTPeticion.GetContent(['TraeListaBodega',
        vItem.ITEM])).Items[0]));

      TThread.Synchronize(TThread.CurrentThread,
        procedure
        var
          vBodega: TBodega;
        begin
          vCodigoCurrentBodega := EmptyStr;
          for vBodega in vListaBodega do
          begin
            if vCodigoCurrentBodega <> vBodega.LOCATION then
            begin
              vCodigoCurrentBodega := vBodega.LOCATION;
              CreaEncabezadoListDisp(vBodega.DES_LOC);
            end;
            CreaItemListDisponibilidad(vItem, vBodega.LOCATION, vBodega.LOTE,
              vBodega.CANTIDAD.ToDouble, vBodega.LOTEFVENCE);
          end;
        end);
    except
      if Assigned(OnEventoErrorConexion) then
        OnEventoErrorConexion(Sender);
    end;
  finally
    TThread.Synchronize(TThread.CurrentThread,
      procedure
      begin
        lblItemSeleccionado.BeginUpdate;
        lblItemSeleccionado.Text := vItem.DESCRIPCION;
        lblNoExistencias.Visible := (vListaBodega.Count = 0);
        lblItemSeleccionado.EndUpdate;
        // lblItemSeleccionado.Repaint;
      end);
    vUM.DisposeOf;
    vListaBodega.DisposeOf;
  end;
  CancelarTasks;
  TCBusquedaItems.ActiveTab := TIDisponibilidadItem;

end;

procedure TMain.PutCantidadItem(pValue: TListViewItem);
begin
  SetLength(vTasks, Length(vTasks) + 1);
  vTasks[Length(vTasks) - 1] := TTask.Run(
    procedure
    var
      vStrCantidad: String;
      vItem: TListItemText;
    begin
      vItem := TListItemText(pValue.View.FindDrawable('CantidadItem'));
      vItem.Height := pValue.Height;
      vItem.TextVertAlign := TTextAlign.Center;

      if not TThread.CurrentThread.CheckTerminated then
      begin
        if pValue.TagObject <> nil then
        begin
          vStrCantidad := 'Cantidad: ' + FormatFloat('###,###,##0',
            TJSONArray(TRESTPeticion.GetContent(['DisponibilidadTotal',
            TItem(pValue.TagObject).ITEM])).Items[0].Value.ToDouble);

          TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              vItem.BeginUpdate;
              vItem.Text := vStrCantidad;
              vItem.EndUpdate;
            end);
        end;
      end;
    end);
end;

procedure TMain.SBItemsKeyDown(Sender: TObject; var Key: Word;
var KeyChar: Char; Shift: TShiftState);
var
  vItem: TItem;
  vUM: TJSONUnMarshal;
  vListViewITEMS: TListViewItem;
begin
  if Key = 13 then
  begin
    if TCBusquedaItems.ActiveTab = TIBusquedaItems then
    begin
      if ((Length(Trim(SBItems.Text)) >= 3)) then
      begin
        vUM := TJSONUnMarshal.Create;
        vListaItem := TObjectList<TItem>.Create;

        try

          vListaItem := TObjectList<TItem>
            (vUM.Unmarshal(TJSONArray(TRESTPeticion.GetContent(['TraeListaItem',
            DMGeneral.vgUsuario, DMGeneral.vgCliente, ReplaceStr(SBItems.Text,
            ' ', '%')],
            procedure(vMensaje: String)
            begin
              FMX.DialogService.TDialogService.ShowMessage(vMensaje);
            end)).Items[0]));

          CDSItems.EmptyDataSet;
          CDSItems.Close;
          CDSItems.Open;
          for vItem in vListaItem do
          begin
            CDSItems.Append;
            CDSItemsITEM.AsString := vItem.ITEM;
            CDSItemsDESCRIPCION.AsString := vItem.ITEM + '   ' +
              vItem.DESCRIPCION;
            CDSItemsPRICE.AsFloat := vItem.PRICE;
            CDSItemsPRICE_SIN_DESC.AsFloat := vItem.PRICE_SIN_DESC;
            CDSItemsRATE.AsFloat := vItem.RATE;
            CDSItemsMAN_LOTE.AsString := vItem.MAN_LOTE;
            CDSItemsCantidad.AsString := 'Cantidad: ' +
              FormatFloat('###,###,##0',
              TJSONArray(TRESTPeticion.GetContent(['DisponibilidadTotal',
              vItem.ITEM])).Items[0].Value.ToDouble);;
            CDSItems.Post;
          end;
          CDSItems.First;
        finally
          vListaItem.DisposeOf;
        end;
      end;
    end;
  end;

end;

procedure TMain.SBTercerosKeyDown(Sender: TObject; var Key: Word;
var KeyChar: Char; Shift: TShiftState);
var
  vTask: ITask;
  vUM: TJSONUnMarshal;
  vListaTer: TObjectList<TTercero>;
  vTercero: TTercero;
begin
  if TCPrincipal.ActiveTab = TICliente then
  begin
    if (Length(Trim(SBTerceros.Text)) >= 3) then
    begin
      if not vValidacionCorrecta then
      begin
        EstablecerMensaje(MSG_ReviseConexionInternet);
      end
      else
      begin
        ListView1.Items.Clear;
        CPCargando.Visible := True;
        AIPpalCargando.Enabled := True;
        vUM := TJSONUnMarshal.Create;
        vListaTer := TObjectList<TTercero>.Create;
        try
          vListaTer := TObjectList<TTercero>
            (vUM.Unmarshal(TJSONArray(TRESTPeticion.GetContent
            (['TraeListaTerceros', ReplaceStr(SBTerceros.Text, ' ', '%'),
            EdUsuario.Text])).Items[0]));

          CDSTercero.EmptyDataSet;
          CDSTercero.Close;
          CDSTercero.Open;
          for vTercero in vListaTer do
          begin
            CDSTercero.Append;
            CDSTerceroID_N.AsString := vTercero.ID_N;
            CDSTerceroCOMPANY.AsString := vTercero.COMPANY;
            CDSTerceroNIT.AsString := vTercero.NIT;
            CDSTerceroPHONE1.AsString := vTercero.PHONE1;
            CDSTerceroCONTACT1.AsString := vTercero.CONTACT1;
            CDSTerceroCITY.AsString := vTercero.CITY;
            CDSTerceroDEPARTAMENTO.AsString := vTercero.DEPARTAMENTO;
            CDSTerceroPAIS.AsString := vTercero.PAIS;
            CDSTerceroADDR1.AsString := vTercero.ADDR1;
            CDSTerceroCREDITLMT.AsFloat := vTercero.CREDITLMT;
            CDSTercero.Post;
          end;
          CDSTercero.First;
        finally
          vListaTer.DisposeOf;
        end;

        lblNohayTerceros.Visible := (CDSTercero.RecordCount = 0);
        AIPpalCargando.Enabled := False;
        CPCargando.Visible := False;
      end;

    end;
  end;
end;

procedure TMain.SpeedButton2Click(Sender: TObject);
begin
 
  TCPrincipal.ActiveTab := TICliente;
end;

procedure TMain.SpeedButton3Click(Sender: TObject);
begin
  
  TCPrincipal.ActiveTab := TIPedido;
  TAPedido.ActiveTab := TIPedidoItems;
end;

procedure TMain.SpeedButton4Click(Sender: TObject);
begin
  
  TCPrincipal.ActiveTab := TIBucar_Item;
  TCBusquedaItems.ActiveTab := TIBusquedaItems;
  SBItems.SetFocus;
  LVItems.Items.Clear;
  SBItems.Text :='';
end;

procedure TMain.SpeedButton5Click(Sender: TObject);
begin

  TCPrincipal.ActiveTab := TIInformacion_Cliente;
end;

procedure TMain.SpeedButton6Click(Sender: TObject);
begin
  if TAPedido.ActiveTab = TIDetalleItem then
  begin
    try
      if (CDSPedidoD.State in [dsInsert, dsEdit]) then
        CDSPedidoD.Post;
    except
    end;
    TAPedido.ActiveTab := TIPedidoItems;
  end;
end;

procedure TMain.SpeedButton7Click(Sender: TObject);
begin

  TCPrincipal.ActiveTab := TIPedido;
end;

procedure TMain.SpeedButton9Click(Sender: TObject);
begin
if CDSPedidoD.RecordCount <> 0 then
    CDSPedidoD.Delete;
end;

procedure TMain.ValidaYEjecuta(Proc: TProc; out pITask: ITask);
begin
  if not vValidacionCorrecta then
  begin
    EstablecerMensaje(MSG_ReviseConexionInternet);
  end
  else
  begin
    CPCargando.Visible := True;
    AIPpalCargando.Enabled := True;

    pITask := TTask.Run(
      procedure
      begin
        try
          TMonitor.Enter(vlMonitor);
          try
            TThread.Synchronize(TThread.CurrentThread,
              procedure
              begin
                Proc
              end);
          except
            vValidacionCorrecta := False;
            EstablecerMensaje(MSG_ReviseConexionInternet);
          end;
        finally
          TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              AIPpalCargando.Enabled := False;
              CPCargando.Visible := False;
            end);
          TMonitor.Exit(vlMonitor);
        end;
      end);
  end;
end;

end.
