unit UClases;

interface

uses System.SysUtils, Generics.Collections, REST.Client, System.JSON,
  System.Classes, System.Threading, REST.Types;

const
  CNS_BASE_WS = 'http://%s/datasnap/rest/TServerMethods1';

var
  CNS_BASE_URI: String = '';

type
  /// <summary>
  /// Clase para hacer peticiones REST al servidor de lógica de negocio
  /// </summary>
  /// <remarks>
  /// Esta clase se encarga de crear los respectivos componentes en tiempo de
  /// ejecución para conectarse al servidor:
  /// <list type="bullet">
  /// <item>
  /// TRESTClient
  /// </item>
  /// <item>
  /// TRESTRequest
  /// </item>
  /// <item>
  /// TRESTResponse
  /// </item>
  /// </list>
  /// </remarks>
  TRESTPeticion = class
  private
    FClient: TRESTClient;
    FRequest: TRESTRequest;
    FResponse: TRESTResponse;
    FContent: TJSONValue;
    class var FOnError: TProc<String>;
    function GetContent: TJSONValue; overload;
    procedure Inicializar(pOwner: TComponent);
  public

    /// <summary>
    /// Se crea una conexión a una función del servicio y devuelve su
    /// contenido
    /// </summary>
    /// <param name="pMetodoRemoto">
    /// Nombre del método del que se requiere respuesta
    /// </param>
    /// <param name="pParametrosURL">
    /// Lista de parámetros (TRESTRequestParameterList) requeridos por el
    /// método con los valores que se pasan al servicio
    /// </param>
    /// <remarks>
    /// Este método hace la petición al servidor usando el método POST, ideal
    /// para enviar objetos como parámetro
    /// </remarks>
    /// <example>
    /// <code lang="Delphi">procedure
    /// var
    /// vParametroTabla: TConsulta;
    /// vParam: TRESTRequestParameter;
    /// vParams: TRESTRequestParameterList;
    /// vM: TJSONMarshal;
    /// begin
    /// vParametroTabla := TConsulta.Create;
    /// try
    /// vParametroTabla.Tabla := 'EMPLOYEE E, PROJECT P, EMPLOYEE_PROJECT EP';
    /// vParametroTabla.Campos.Add(TCampo.Create('E.FIRST_NAME',
    /// 'PRIMER_NOMBRE'));
    /// vParametroTabla.Campos.Add(TCampo.Create('E.LAST_NAME', 'APELLIDO'));
    /// vParametroTabla.Campos.Add(TCampo.Create('E.PHONE_EXT'));
    /// vParametroTabla.Campos.Add(TCampo.Create('P.PROJ_NAME'));
    /// vParametroTabla.Campos.Add(TCampo.Create('E.SALARY', '', tcSum));
    ///
    /// vM := TJSONMarshal.Create(TJSONConverter.Create);
    ///
    /// vParams := TRESTRequestParameterList.Create(Self);
    /// vParam := vParams.AddItem;
    /// vParam.Name := 'pValor';
    /// vParam.Value := vM.Marshal(vParametroTabla).ToString;
    ///
    /// vFormatoJSON := TRESTPeticion.GetContent('TraeDato2', vParams);
    /// finally
    /// vM.DisposeOf;
    /// vParametroTabla.DisposeOf;
    /// vParams.DisposeOf;
    /// vParam.DisposeOf;
    /// end;
    /// end;</code>
    /// </example>
    class function GetContent(pMetodoRemoto: String; var pParametrosURL: TRESTRequestParameterList): TJSONValue;
      overload; static; inline;
    /// <summary>
    /// Lo mismo que <see cref="SAI.UClasesGlobales|TRESTPeticion.GetContent(string,TRESTRequestParameterList)" />
    /// pero devuelve un objeto de tipo IFuture
    /// </summary>
    class function GetContentFuture(pMetodoRemoto: String; var pParametrosURL: TRESTRequestParameterList)
      : IFuture<TJSONValue>; overload; static;

    /// <summary>
    /// Se crea una conexión a una función del servicio y devuelve su
    /// contenido
    /// </summary>
    /// <param name="pParametrosURL">
    /// Lista de parámetros (TArray) requeridos por el método con los valores
    /// que se pasan al servicio, <b>el primer valor siempre es el nombre del
    /// método que se requiere</b>
    /// </param>
    /// <remarks>
    /// Este método hace la petición al servidor usando el método GET, ideal
    /// para enviar strings sencillos como parámetro
    /// </remarks>
    /// <example>
    /// <code lang="Delphi">//Devuelve el resultado de la función GetFuncionConParametros, entregándole 2 parámetros
    /// TRESTPeticion.GetContent(['GetFuncionConParametros', 'Parametro1', 'Parametro2']);</code>
    /// <code lang="Delphi">//Devuelve el resultado de la función GetFuncionSinParametros
    /// TRESTPeticion.GetContent(['GetFuncionSinParametros']);</code>
    /// </example>
    class function GetContent(pParametrosURL: TArray<String>; pOnError: TProc<String> = nil): TJSONValue; overload;
      static; inline;
    /// <summary>
    /// Lo mismo que <see cref="SAI.UClasesGlobales|TRESTPeticion.GetContent(TArray)" />
    /// pero devuelve un objeto de tipo IFuture
    /// </summary>
    class function GetContentFuture(pParametrosURL: TArray<String>): IFuture<TJSONValue>; overload; static;

    property Client: TRESTClient read FClient write FClient;
    property Request: TRESTRequest read FRequest write FRequest;
    property Response: TRESTResponse read FResponse write FResponse;

    /// <summary>
    /// Respuesta de la petición
    /// </summary>
    /// <remarks>
    /// Si se lee esta propiedad ella se conectará al servicio y traerá el
    /// resultado en un objeto de tipo TJSONValue, si en una misma instancia
    /// de la clase ya se ha leído esta propiedad, ella devolverá el
    /// resultado desde el cache y no se conectará al servidor
    /// <note type="tip">
    /// Para obligar a que se conecte al servicio habrá que utilizar el
    /// método <see cref="SAI.UClasesGlobales|TRESTPeticion.ResetContent">
    /// ResetContent</see> antes de leer esta propiedad
    /// </note>
    /// </remarks>
    /// <example>
    /// <code lang="Delphi">//En una variable global se declaró vPeticion :TRESTPeticion;
    /// //En el OnCreate de un formulario se construye una instancia
    /// vPeticion := TRESTPeticion.Create(nil, ['ReverseString', 'AlgúnString']);
    /// //En algún lado se escribe...
    /// vPeticion.ResetContent; //Esto obligaría al objeto a realizar la consulta siempre conectándose al servidorShowMessage(vPeticion.Content.ToJSON);</code>
    /// </example>
    property Content: TJSONValue read GetContent;

    /// <param name="pOwner">
    /// Componente Owner
    /// </param>
    /// <param name="pParametrosURL">
    /// Lista de parámetros (TArray) requeridos por el método con los valores
    /// que se pasan al servicio, <b>el primer valor siempre es el nombre del
    /// método</b> que se requiere <br />
    /// </param>
    /// <example>
    /// Visitar <see cref="SAI.UClasesGlobales|TRESTPeticion.GetContent(TArray)" />
    /// para visualizar el ejemplo
    /// </example>
    constructor Create(pOwner: TComponent; pParametrosURL: TArray<String>); overload;

    /// <param name="pOwner">
    /// Owner del objeto
    /// </param>
    /// <param name="pMetodoRemoto">
    /// Nombre del método remoto a solicitar
    /// </param>
    /// <param name="pParametrosURL">
    /// Lista de parámetros TRESTRequestParameterList del método
    /// </param>
    /// <remarks>
    /// Ideal para enviar párametros como objetos.
    /// <note type="tip">
    /// El método de petición al servidor por defecto al crear una
    /// instancia con este constructor es POST
    /// </note>
    /// </remarks>
    /// <example>
    /// Ver <see cref="SAI.UClasesGlobales|TRESTPeticion.GetContent(string,TRESTRequestParameterList)">
    /// GetContent</see> para ejemplo
    /// </example>
    constructor Create(pOwner: TComponent; pMetodoRemoto: String;
      var pParametrosURL: TRESTRequestParameterList); overload;

    /// <summary>
    /// Vacía el contenido de la propiedad <see cref="SAI.UClasesGlobales|TRESTPeticion.Content">
    /// Content</see>
    /// </summary>
    /// <remarks>
    /// Vacía el contenido de la propiedad <see cref="SAI.UClasesGlobales|TRESTPeticion.Content">
    /// Content</see>, si se ejecuta este método, la próxima lectura de la
    /// propiedad <see cref="SAI.UClasesGlobales|TRESTPeticion.Content">
    /// Content</see> se conectará al servidor.
    /// </remarks>
    procedure ResetContent;

    destructor Destroy; override;
  end;

type
  TItem = class(TPersistent)
  private
    FPRICE: double;
    FRATE: double;
    FITEM: String;
    FMAN_LOTE: String;
    FDESCRIPCION: String;
    FPRICE_SIN_DESC: double;
  public
    property ITEM: String read FITEM write FITEM;
    property DESCRIPCION: String read FDESCRIPCION write FDESCRIPCION;
    property PRICE: double read FPRICE write FPRICE;
    property PRICE_SIN_DESC: double read FPRICE_SIN_DESC write FPRICE_SIN_DESC;
    property RATE: double read FRATE write FRATE;
    property MAN_LOTE: String read FMAN_LOTE write FMAN_LOTE;
  end;

type
  TBusPedido = class(TPersistent)
  private
    FSUBTOTAL: double;
    FAUTORIZADO: String;
    FFECHA: TDate;
    FTOTAL: double;
    FNUMBER: Integer;
    FTOTALPEDIDO: double;
    FESTADO: String;

  public
    property NUMBER: Integer read FNUMBER write FNUMBER;
    property FECHA: TDate read FFECHA write FFECHA;
    property SUBTOTAL: double read FSUBTOTAL write FSUBTOTAL;
    property TOTAL: double read FTOTAL write FTOTAL;
    property TOTALPEDIDO: double read FTOTALPEDIDO write FTOTALPEDIDO;
    property ESTADO: String read FESTADO write FESTADO;
    property AUTORIZADO: String read FAUTORIZADO write FAUTORIZADO;

  end;

type
  TBodega = class(TPersistent)
  private
    FLOTEFVENCE: TDate;
    FLOCATION: String;
    FLOTE: String;
    FDES_LOC: String;
    FCANTIDAD: String;

  public
    property CANTIDAD: String read FCANTIDAD write FCANTIDAD;
    property LOCATION: String read FLOCATION write FLOCATION;
    property LOTE: String read FLOTE write FLOTE;
    property DES_LOC: String read FDES_LOC write FDES_LOC;
    property LOTEFVENCE: TDate read FLOTEFVENCE write FLOTEFVENCE;
  end;

type
  TShipto = class(TPersistent)
  private
    FPHONE2: String;
    FID_N: String;
    FPHONE3: String;
    FPHONE1: String;
    FSUCCLIENTE: Integer;
    FCOMPANY: String;
  public
    property ID_N: String read FID_N write FID_N;
    property SUCCLIENTE: Integer read FSUCCLIENTE write FSUCCLIENTE;
    property COMPANY: String read FCOMPANY write FCOMPANY;
    property PHONE1: String read FPHONE1 write FPHONE1;
    property PHONE2: String read FPHONE2 write FPHONE2;
    property PHONE3: String read FPHONE3 write FPHONE3;
  end;
{$METHODINFO ON}

type
  TCartera = class(TPersistent)
  private
    FID_N: String;
    FFECHA: TDate;
    FDIAS_VENCIMIENTO: Integer;
    FBATCH: Integer;
    FSALDO: double;
    FDUEDATE: TDate;
    FTIPO: String;

  public
    property ID_N: String read FID_N write FID_N;
    property TIPO: String read FTIPO write FTIPO;
    property BATCH: Integer read FBATCH write FBATCH;
    property FECHA: TDate read FFECHA write FFECHA;
    property DUEDATE: TDate read FDUEDATE write FDUEDATE;
    property DIAS_VENCIMIENTO: Integer read FDIAS_VENCIMIENTO write FDIAS_VENCIMIENTO;
    property SALDO: double read FSALDO write FSALDO;
  end;

type
  TTercero = class(TPersistent)
  private
    FCREDITLMT: double;
    FNIT: String;
    FID_N: String;
    FPHONE1: String;
    FCOMPANY: String;
    FDEPARTAMENTO: String;
    FADDR1: String;
    FCONTACT1: String;
    FCITY: String;
    FPAIS: String;
  public
    property ID_N: String read FID_N write FID_N;
    property COMPANY: String read FCOMPANY write FCOMPANY;
    property NIT: String read FNIT write FNIT;
    property PHONE1: String read FPHONE1 write FPHONE1;
    property CONTACT1: String read FCONTACT1 write FCONTACT1;
    property CITY: String read FCITY write FCITY;
    property DEPARTAMENTO: String read FDEPARTAMENTO write FDEPARTAMENTO;
    property PAIS: String read FPAIS write FPAIS;
    property ADDR1: String read FADDR1 write FADDR1;
    property CREDITLMT: double read FCREDITLMT write FCREDITLMT;
  end;

type
  TListaDummyTercero = class(TObjectList<TTercero>);
  TListaDummyShipto = class(TObjectList<TShipto>);
  TListaDummyCartera = class(TObjectList<TCartera>);
  TListaDummyItem = class(TObjectList<TItem>);
  TListaDummyBodega = class(TObjectList<TBodega>);
  TListaDummyPedidos = class(TObjectList<TBusPedido>);

type
{$METHODINFO ON}
  TPedidoDet = class
  private
    FID_EMPRESA: Integer;
    FID_SUCURSAL: Integer;
    FTIPO: String;
    FNUMBER: Integer;
    FCONTEO: Integer;
    FITEM: String;
    FIMPOVENTA: String;
    FLOCATION: String;
    FQTYSHIP: double;
    FQTYORDER: double;
    FPRICE: double;
    FEXTENDED: double;
    FTAXES: double;
    FCOST: double;
    FNOTES: String;
    FDIAS_GARANTIA: Integer;
    FDCT: double;
    FTOTALDCT: double;
    FVLR_IVA: double;
    FPORC_IVA: double;
    FCAJAS: Integer;
    FPESO_BRUTO: double;
    FTIPO_FACTOR: String;
    FDOBLE_UNIDAD: String;
    FUSAR_DESVIACION: String;
    FDESVIACION_NP: double;
    FPESO_PROMEDIOI: double;
    FFALLO: String;
    FPESO_NETOI: double;
    FPRECIO_VENDEDOR: double;
    FAUTORIZADO: String;
    FORIGEN: String;
    FNUM_SERIAL: String;
    FBO: double;
    FRESERVA: double;
    FDCTADICIONAL: double;
    FDCTFIJO: double;
    FESTADO: String;
    FQTY_REMISIONADA: double;
    FTIPO_COTIZA: String;
    FNUMERO_COTIZA: Integer;
    FKITNO: String;
    FKIT_DESCRIPCION: String;
    FDCT_AD1: double;
    FDCT_AD2: double;
    FVLR_DCTFIJO: double;
    FVLR_DCT: double;
    FVLR_DCTOAD1: double;
    FVLR_DCTOAD2: double;
    FVLR_DCTOADICIONAL: double;
    FOCNUMERO: String;
    FMANDANTE: String;
    FCOD_CENTRO: Integer;
    FDESCRIP_CENTRO: String;
    FDIAS_ITEM: Integer;
    FKILOMETRAJE: Integer;
    FPORC_COMI: double;
    FPROYECTO: String;
    FACTIVIDAD: String;
    FDPTO: Integer;
    FCCOST: Integer;
    FCOD_TALLA: String;
    FCOD_COLOR: String;
    FPRECIOIVA: double;
    FITEM_DESC: String;
    FEXTEND: double;
  public
    property ID_EMPRESA: Integer read FID_EMPRESA write FID_EMPRESA;
    property ID_SUCURSAL: Integer read FID_SUCURSAL write FID_SUCURSAL;
    property TIPO: String read FTIPO write FTIPO;
    property NUMBER: Integer read FNUMBER write FNUMBER;
    property CONTEO: Integer read FCONTEO write FCONTEO;
    property ITEM: String read FITEM write FITEM;
    property IMPOVENTA: String read FIMPOVENTA write FIMPOVENTA;
    property LOCATION: String read FLOCATION write FLOCATION;
    property QTYSHIP: double read FQTYSHIP write FQTYSHIP;
    property QTYORDER: double read FQTYORDER write FQTYORDER;
    property PRICE: double read FPRICE write FPRICE;
    property EXTENDED: double read FEXTENDED write FEXTENDED;
    property EXTEND: double read FEXTEND write FEXTEND;
    // Autocalculado...
    property TAXES: double read FTAXES write FTAXES;
    property COST: double read FCOST write FCOST;
    property NOTES: String read FNOTES write FNOTES;
    property DIAS_GARANTIA: Integer read FDIAS_GARANTIA write FDIAS_GARANTIA;
    property DCT: double read FDCT write FDCT;
    property TOTALDCT: double read FTOTALDCT write FTOTALDCT;
    property VLR_IVA: double read FVLR_IVA write FVLR_IVA; // Autocalculado...
    property PORC_IVA: double read FPORC_IVA write FPORC_IVA;
    property CAJAS: Integer read FCAJAS write FCAJAS;
    property PESO_BRUTO: double read FPESO_BRUTO write FPESO_BRUTO;
    property TIPO_FACTOR: String read FTIPO_FACTOR write FTIPO_FACTOR;
    property DOBLE_UNIDAD: String read FDOBLE_UNIDAD write FDOBLE_UNIDAD;
    property USAR_DESVIACION: String read FUSAR_DESVIACION write FUSAR_DESVIACION;
    property DESVIACION_NP: double read FDESVIACION_NP write FDESVIACION_NP;
    property PESO_PROMEDIOI: double read FPESO_PROMEDIOI write FPESO_PROMEDIOI;
    property FALLO: String read FFALLO write FFALLO;
    property PESO_NETOI: double read FPESO_NETOI write FPESO_NETOI;
    property PRECIO_VENDEDOR: double read FPRECIO_VENDEDOR write FPRECIO_VENDEDOR;
    property AUTORIZADO: String read FAUTORIZADO write FAUTORIZADO;
    property ORIGEN: String read FORIGEN write FORIGEN;
    property NUM_SERIAL: String read FNUM_SERIAL write FNUM_SERIAL;
    property BO: double read FBO write FBO;
    property RESERVA: double read FRESERVA write FRESERVA;
    property DCTADICIONAL: double read FDCTADICIONAL write FDCTADICIONAL;
    property DCTFIJO: double read FDCTFIJO write FDCTFIJO;
    property ESTADO: String read FESTADO write FESTADO;
    property QTY_REMISIONADA: double read FQTY_REMISIONADA write FQTY_REMISIONADA;
    property TIPO_COTIZA: String read FTIPO_COTIZA write FTIPO_COTIZA;
    property NUMERO_COTIZA: Integer read FNUMERO_COTIZA write FNUMERO_COTIZA;
    property KITNO: String read FKITNO write FKITNO;
    property KIT_DESCRIPCION: String read FKIT_DESCRIPCION write FKIT_DESCRIPCION;
    property DCT_AD1: double read FDCT_AD1 write FDCT_AD1;
    property DCT_AD2: double read FDCT_AD2 write FDCT_AD2;
    property VLR_DCTFIJO: double read FVLR_DCTFIJO write FVLR_DCTFIJO;
    property VLR_DCT: double read FVLR_DCT write FVLR_DCT;
    property VLR_DCTOAD1: double read FVLR_DCTOAD1 write FVLR_DCTOAD1;
    property VLR_DCTOAD2: double read FVLR_DCTOAD2 write FVLR_DCTOAD2;
    property VLR_DCTOADICIONAL: double read FVLR_DCTOADICIONAL write FVLR_DCTOADICIONAL;
    property OCNUMERO: String read FOCNUMERO write FOCNUMERO;
    property MANDANTE: String read FMANDANTE write FMANDANTE;
    property COD_CENTRO: Integer read FCOD_CENTRO write FCOD_CENTRO;
    property DESCRIP_CENTRO: String read FDESCRIP_CENTRO write FDESCRIP_CENTRO;
    property DIAS_ITEM: Integer read FDIAS_ITEM write FDIAS_ITEM;
    property KILOMETRAJE: Integer read FKILOMETRAJE write FKILOMETRAJE;
    property PORC_COMI: double read FPORC_COMI write FPORC_COMI;
    property PROYECTO: String read FPROYECTO write FPROYECTO;
    property ACTIVIDAD: String read FACTIVIDAD write FACTIVIDAD;
    property DPTO: Integer read FDPTO write FDPTO;
    property CCOST: Integer read FCCOST write FCCOST;
    property COD_TALLA: String read FCOD_TALLA write FCOD_TALLA;
    property COD_COLOR: String read FCOD_COLOR write FCOD_COLOR;
    property PRECIOIVA: double read FPRECIOIVA write FPRECIOIVA;
    property ITEM_DESC: String read FITEM_DESC write FITEM_DESC;

    constructor Create(AOwner: TObject);
  end;

type
  TPedidoDetEvent = procedure(Index: Integer) of object;
  TPedidoDetModicaEvent = procedure(OldValue: TPedidoDet) of object;

type
{$METHODINFO ON}
  TPedido = class
  private
    FID_EMPRESA: Integer;
    FID_SUCURSAL: Integer;
    FTIPO: String;
    FNUMBER: Integer;
    FTIPO_PEDIDO: String;
    FID_USUARIO: String;
    FID_N: String;
    FSUCCLIENTE: Integer;
    FENTITY: String;
    FSALESMAN: Integer;
    FNUMBERFROM: String;
    FNUMBERTO: String;
    FFECHA: TDateTime;
    FSUBTOTAL: double;
    FCOST: double;
    FSALESTAX: double;
    FFEDTAX: double;
    FDISC1: double;
    FDISC2: double;
    FDISC3: double;
    FSHIPTO1: String;
    FSHIPTO2: String;
    FSHIPTO3: String;
    FSHIPTO4: String;
    FSHIPTO5: String;
    FSHIPTO6: String;
    FONACCOUNT: String;
    FPRINTED: String;
    FPOSTED: String;
    FPONUMBER: String;
    FTERMS: String;
    FJOBNO: String;
    FDES_GLO: double;
    FPOR_DES: double;
    FCOD_ORD: sTRING;
    FRPT_NUM: String;
    FDESTOTAL: double;
    FTOTAL: double;
    FTOTALPEDIDO: double;
    FESTADO: String;
    FAUTORIZADO: String;
    FAPROB_BANCO: String;
    FCONCEPTO: Integer;
    FDESCRIPCION: String;
    FTIENE_GAR: String;
    FOCNUMERO: String;
    FCODACTIVIDAD: String;
    FCODPROYECTO: String;
    FFECHA_ENTREGA: TDateTime;
    FID_USUARIO_FACTURACION: String;
    FREMISIONADO: String;
    FHORA: String;
    FFECHA_SISTEMA: TDateTime;
    FDESCRIPCION_RECETA: String;
    FCOD_PLACA: String;
    FCOMMENTS: String;
    FVALOR_ABONO: double;
    FPedidoDet: TList<TPedidoDet>;
    FOnAgregaPedidoDet: TPedidoDetEvent;
    FOnEliminaPedidoDet: TPedidoDetEvent;
    FOnModificaPedidoDet: TPedidoDetModicaEvent;
    procedure Iniciar;
  public
    property ID_EMPRESA: Integer read FID_EMPRESA write FID_EMPRESA;
    property ID_SUCURSAL: Integer read FID_SUCURSAL write FID_SUCURSAL;
    property TIPO: String read FTIPO write FTIPO;
    property NUMBER: Integer read FNUMBER write FNUMBER;
    property TIPO_PEDIDO: String read FTIPO_PEDIDO write FTIPO_PEDIDO;
    property ID_USUARIO: String read FID_USUARIO write FID_USUARIO;
    property ID_N: String read FID_N write FID_N;
    property SUCCLIENTE: Integer read FSUCCLIENTE write FSUCCLIENTE;
    property ENTITY: String read FENTITY write FENTITY;
    property SALESMAN: Integer read FSALESMAN write FSALESMAN;
    property NUMBERFROM: String read FNUMBERFROM write FNUMBERFROM;
    property NUMBERTO: String read FNUMBERTO write FNUMBERTO;
    property FECHA: TDateTime read FFECHA write FFECHA;
    property SUBTOTAL: double read FSUBTOTAL write FSUBTOTAL;
    property COST: double read FCOST write FCOST;
    property SALESTAX: double read FSALESTAX write FSALESTAX;
    property FEDTAX: double read FFEDTAX write FFEDTAX;
    property DISC1: double read FDISC1 write FDISC1;
    property DISC2: double read FDISC2 write FDISC2;
    property DISC3: double read FDISC3 write FDISC3;
    property SHIPTO1: String read FSHIPTO1 write FSHIPTO1;
    property SHIPTO2: String read FSHIPTO2 write FSHIPTO2;
    property SHIPTO3: String read FSHIPTO3 write FSHIPTO3;
    property SHIPTO4: String read FSHIPTO4 write FSHIPTO4;
    property SHIPTO5: String read FSHIPTO5 write FSHIPTO5;
    property SHIPTO6: String read FSHIPTO6 write FSHIPTO6;
    property ONACCOUNT: String read FONACCOUNT write FONACCOUNT;
    property PRINTED: String read FPRINTED write FPRINTED;
    property POSTED: String read FPOSTED write FPOSTED;
    property PONUMBER: String read FPONUMBER write FPONUMBER;
    property TERMS: String read FTERMS write FTERMS;
    property JOBNO: String read FJOBNO write FJOBNO;
    property DES_GLO: double read FDES_GLO write FDES_GLO;
    property POR_DES: double read FPOR_DES write FPOR_DES;
    property COD_ORD: sTRING read FCOD_ORD write FCOD_ORD;
    property RPT_NUM: String read FRPT_NUM write FRPT_NUM;
    property DESTOTAL: double read FDESTOTAL write FDESTOTAL;
    property TOTAL: double read FTOTAL write FTOTAL; // Pedido con IVA
    property TOTALPEDIDO: double read FTOTALPEDIDO write FTOTALPEDIDO;
    // Pedido sin IVA
    property ESTADO: String read FESTADO write FESTADO;
    property AUTORIZADO: String read FAUTORIZADO write FAUTORIZADO;
    property APROB_BANCO: String read FAPROB_BANCO write FAPROB_BANCO;
    property CONCEPTO: Integer read FCONCEPTO write FCONCEPTO;
    property DESCRIPCION: String read FDESCRIPCION write FDESCRIPCION;
    property TIENE_GAR: String read FTIENE_GAR write FTIENE_GAR;
    property OCNUMERO: String read FOCNUMERO write FOCNUMERO;
    property CODACTIVIDAD: String read FCODACTIVIDAD write FCODACTIVIDAD;
    property CODPROYECTO: String read FCODPROYECTO write FCODPROYECTO;
    property FECHA_ENTREGA: TDateTime read FFECHA_ENTREGA write FFECHA_ENTREGA;
    property ID_USUARIO_FACTURACION: String read FID_USUARIO_FACTURACION write FID_USUARIO_FACTURACION;
    property REMISIONADO: String read FREMISIONADO write FREMISIONADO;
    property HORA: String read FHORA write FHORA;
    property FECHA_SISTEMA: TDateTime read FFECHA_SISTEMA write FFECHA_SISTEMA;
    property DESCRIPCION_RECETA: String read FDESCRIPCION_RECETA write FDESCRIPCION_RECETA;
    property COD_PLACA: String read FCOD_PLACA write FCOD_PLACA;
    property COMMENTS: String read FCOMMENTS write FCOMMENTS;
    property VALOR_ABONO: double read FVALOR_ABONO write FVALOR_ABONO;

    // Detalle del pedido, una lista de TPedidoDet...
    property PedidoDet: TList<TPedidoDet> read FPedidoDet;

    // Eventos
    property OnAgregaPedidoDet: TPedidoDetEvent read FOnAgregaPedidoDet write FOnAgregaPedidoDet;
    property OnEliminaPedidoDet: TPedidoDetEvent read FOnEliminaPedidoDet write FOnEliminaPedidoDet;
    property OnModificaPedidoDet: TPedidoDetModicaEvent read FOnModificaPedidoDet write FOnModificaPedidoDet;

    // Metodos para administrar PedidoDet
    function TraePorItem(ITEM: String): TPedidoDet;
    procedure AgregaPedidoDet(Value: TPedidoDet);
    procedure EliminarPedidoDet(Index: Integer);
    procedure ModificarPedidoDet(Index: Integer; NewValue: TPedidoDet);

    constructor Create; overload;
    constructor Create(APedidoDet: TList<TPedidoDet>); overload;
    destructor Destroy;
  end;

implementation

{ TPedido }

constructor TPedido.Create;
begin
  Iniciar;
end;

procedure TPedido.AgregaPedidoDet(Value: TPedidoDet);
begin
  Value.CONTEO := FPedidoDet.Add(Value);
  if Assigned(FOnAgregaPedidoDet) then
    FOnAgregaPedidoDet(Value.CONTEO);
end;

constructor TPedido.Create(APedidoDet: TList<TPedidoDet>);
begin
  Iniciar;
  FPedidoDet := APedidoDet;
end;

destructor TPedido.Destroy;
begin
  FPedidoDet.Free;
end;

procedure TPedido.EliminarPedidoDet(Index: Integer);
begin
  FPedidoDet.Delete(Index);
  if Assigned(FOnEliminaPedidoDet) then
    FOnEliminaPedidoDet(Index);
end;

procedure TPedido.Iniciar;
begin
  FPedidoDet := TList<TPedidoDet>.Create;

  // Por defecto
  FID_EMPRESA := 1;
  FID_SUCURSAL := 1;
  FNUMBER := 0;
  FTIPO := 'PPM';
  FFECHA := Date;
  FSUBTOTAL := 0;
  FCOST := 0;
  FSALESTAX := 0;
  FDISC1 := 0;
  FDISC2 := 0;
  FDISC3 := 0;
  FDESTOTAL := 0;
  FTOTAL := 0;
  FTOTALPEDIDO := 0;
  FESTADO := 'PENDIENTE';
  FAUTORIZADO := 'False';
  FAPROB_BANCO := 'False';
  FCONCEPTO := 1;
  FDESCRIPCION := '';
  FTIENE_GAR := 'False';
  FCODACTIVIDAD := '';
  FCODPROYECTO := '';
  FID_USUARIO_FACTURACION := '';
  FREMISIONADO := 'N';

  // Valores Fijos...
  FTIPO_PEDIDO := 'NEGOCIO';
  FSUCCLIENTE := 0;
  FEDTAX := 0;
  FSHIPTO1 := '';
  FSHIPTO2 := '';
  FSHIPTO3 := '';
  FSHIPTO4 := '';
  FSHIPTO5 := '';
  FSHIPTO6 := '';
  FONACCOUNT := '';
  FPRINTED := 'False';
  FPOSTED := 'False';
  FPONUMBER := '';
  FTERMS := '';
  FJOBNO := '';
  FDES_GLO := 0;
  FPOR_DES := 0;
  FCOD_ORD := '';
  FRPT_NUM := '';
  FHORA := '';
  FFECHA_SISTEMA := Date;
  FDESCRIPCION_RECETA := '';
  FCOD_PLACA := '';
  FCOMMENTS := '';
  FVALOR_ABONO := 0;
end;

procedure TPedido.ModificarPedidoDet(Index: Integer; NewValue: TPedidoDet);
var
  vOldValue: TPedidoDet;
begin
  vOldValue := PedidoDet.Items[Index];
  FPedidoDet.Items[Index] := NewValue;

  if Assigned(FOnModificaPedidoDet) then
    FOnModificaPedidoDet(vOldValue);
end;

function TPedido.TraePorItem(ITEM: String): TPedidoDet;
var
  vPedidoDet: TPedidoDet;
begin
  Result := nil;
  for vPedidoDet in FPedidoDet do
    if vPedidoDet.ITEM = ITEM then
      Result := vPedidoDet;
end;

{ TPedidoDet }

constructor TPedidoDet.Create(AOwner: TObject);
begin
  if AOwner.ClassType = TPedido then
  begin
    FID_EMPRESA := TPedido(AOwner).ID_EMPRESA;
    FID_SUCURSAL := TPedido(AOwner).ID_SUCURSAL;
    FTIPO := TPedido(AOwner).TIPO;
    FNUMBER := TPedido(AOwner).NUMBER;
  end;

  // Por defecto...
  FCONTEO := 0;
  FITEM := '';
  FPRECIOIVA := 0;;
  FESTADO := 'PENDIENTE';
  FAUTORIZADO := 'False';
  FPRECIO_VENDEDOR := 0;
  FTIPO_FACTOR := 'Unidad';
  FPORC_IVA := 0;
  FVLR_IVA := 0;
  FTOTALDCT := 0;
  FDCT := 0;
  FNOTES := '';
  FCOST := 0;
  FEXTENDED := 0;
  FPRICE := 0;
  FQTYORDER := 0;
  FQTYSHIP := 0;
  FLOCATION := '';
  FIMPOVENTA := '';

  // Valor fijo...
  FTAXES := 0;
  FDIAS_GARANTIA := 0;
  FCAJAS := 0;
  FPESO_BRUTO := 0;
  FDOBLE_UNIDAD := 'False';
  FUSAR_DESVIACION := '';
  FDESVIACION_NP := 0;
  FPESO_PROMEDIOI := 0;
  FFALLO := '';
  FPESO_NETOI := 0;
  FORIGEN := '';
  FNUM_SERIAL := '';
  FBO := 0;
  FRESERVA := 0;
  FDCTADICIONAL := 0;
  FDCTFIJO := 0;
  FQTY_REMISIONADA := 0;
  FTIPO_COTIZA := '';
  FNUMERO_COTIZA := 0;
  FKITNO := '';
  FKIT_DESCRIPCION := '';
  FDCT_AD1 := 0;
  FDCT_AD2 := 0;
  FVLR_DCTFIJO := 0;
  FVLR_DCT := 0;
  FVLR_DCTOAD1 := 0;
  FVLR_DCTOAD2 := 0;
  FVLR_DCTOADICIONAL := 0;
  FOCNUMERO := '';
  FMANDANTE := '';
  FCOD_COLOR := '';
  FCOD_TALLA := '';
  FDPTO := 0;
  FCCOST := 0;
  FACTIVIDAD := '';
  FPROYECTO := '';
  FPORC_COMI := 0;
  FKILOMETRAJE := 0;
  FDIAS_ITEM := 0;
  FDESCRIP_CENTRO := '';
  FCOD_CENTRO := 0;
end;

{ TRESTPeticion }

constructor TRESTPeticion.Create(pOwner: TComponent; pParametrosURL: TArray<String>);
var
  pParametro: String;
begin
  Inicializar(pOwner);
  for pParametro in pParametrosURL do
    FClient.BaseURL := FClient.BaseURL + '/' + pParametro;
end;

constructor TRESTPeticion.Create(pOwner: TComponent; pMetodoRemoto: String;
  var pParametrosURL: TRESTRequestParameterList);
var
  vParametro: TRESTRequestParameter;
begin
  Inicializar(pOwner);

  FClient.BaseURL := FClient.BaseURL + '/' + pMetodoRemoto;
  FRequest.Method := rmPOST;

  for vParametro in pParametrosURL do
  begin
    vParametro.Kind := TRESTRequestParameterKind.pkGETorPOST;
    vParametro.ContentType := TRESTContentType.ctAPPLICATION_JSON;
  end;

  FRequest.Params := pParametrosURL;
end;

destructor TRESTPeticion.Destroy;
begin
  FClient.DisposeOf;
  FRequest.DisposeOf;
  FResponse.DisposeOf;
  inherited;
end;

function TRESTPeticion.GetContent: TJSONValue;
begin
  if not Assigned(FContent) then
  begin
    try
      FRequest.Execute;
      FContent := TJSONObject.ParseJSONValue(FResponse.Content);
    except
      on E: Exception do
      begin
        TThread.Synchronize(TThread.CurrentThread,
          procedure
          var
            vMensaje: String;
          begin
            if Assigned(TJSONObject.ParseJSONValue(FResponse.Content)) then
              vMensaje := TJSONObject(TJSONObject.ParseJSONValue(FResponse.Content)).GetValue('error').ToString
            else
              vMensaje := E.Message;

            if Assigned(FOnError) then
              FOnError(vMensaje);

            // raise Exception.Create(vMensaje);
            // SAI.UObservadores.vgMensajeObserver.MensajeError := vMensaje;
          end);
//        Abort;
      end;
    end;
  end;
  Result := FContent;
  FClient.Disconnect;
end;

class function TRESTPeticion.GetContent(pMetodoRemoto: String; var pParametrosURL: TRESTRequestParameterList)
  : TJSONValue;
var
  vRestPeticion: TRESTPeticion;
begin
  vRestPeticion := TRESTPeticion.Create(nil, pMetodoRemoto, pParametrosURL);
  try
    Result := vRestPeticion.Content;
  finally
    vRestPeticion.DisposeOf;
  end;
end;

class function TRESTPeticion.GetContent(pParametrosURL: TArray<String>; pOnError: TProc<String> = nil): TJSONValue;
var
  vRestPeticion: TRESTPeticion;
begin
  vRestPeticion := TRESTPeticion.Create(nil, pParametrosURL);
  try
    FOnError := pOnError;

    Result := vRestPeticion.Content;
  finally
    vRestPeticion.DisposeOf;
  end;
end;

class function TRESTPeticion.GetContentFuture(pMetodoRemoto: String; var pParametrosURL: TRESTRequestParameterList)
  : IFuture<TJSONValue>;
var
  vParametrosURL: TRESTRequestParameterList;
begin
  vParametrosURL := pParametrosURL;
  Result := TTask.Future<TJSONValue>(
    function: TJSONValue
    var
      vRestPeticion: TRESTPeticion;
    begin
      vRestPeticion := TRESTPeticion.Create(nil, pMetodoRemoto, vParametrosURL);
      try
        Result := vRestPeticion.Content;
      finally
        vRestPeticion.DisposeOf;
      end;
    end);
end;

class function TRESTPeticion.GetContentFuture(pParametrosURL: TArray<String>): IFuture<TJSONValue>;
begin
  Result := TTask.Future<TJSONValue>(
    function: TJSONValue
    var
      vRestPeticion: TRESTPeticion;
    begin
      vRestPeticion := TRESTPeticion.Create(nil, pParametrosURL);
      try
        Result := vRestPeticion.Content;
      finally
        vRestPeticion.DisposeOf;
      end;
    end);
end;

procedure TRESTPeticion.Inicializar(pOwner: TComponent);
begin
  FClient := TRESTClient.Create(pOwner);
  FRequest := TRESTRequest.Create(pOwner);
  FResponse := TRESTResponse.Create(pOwner);

  FClient.BaseURL := CNS_BASE_URI;

  FRequest.Client := FClient;
  FRequest.Response := FResponse;
end;

procedure TRESTPeticion.ResetContent;
begin
  FreeAndNil(FContent);
end;

end.
