unit untApp;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, FMX.ListBox, FMX.Effects,
  FMX.Media

  {$IFDEF ANDROID}
    ,UI.Toast
  {$ENDIF ANDROID}


  ;

type
  TfrmApplication = class(TForm)
    ToolBar1: TToolBar;
    Label1: TLabel;
    btnMore: TSpeedButton;
    btnSair: TSpeedButton;
    imgCamera: TImage;
    btnCamera: TSpeedButton;
    lbPopup: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ShadowEffect1: TShadowEffect;
    btnBaixa: TSpeedButton;
    btnMedia: TSpeedButton;
    btnAlta: TSpeedButton;
    btnMaxima: TSpeedButton;
    CameraComponent: TCameraComponent;
    procedure MudaQualidade (const NovaQualidade: TVideoCaptureQuality);
    procedure FormShow(Sender: TObject);
    procedure PegarImagem;
    procedure CameraComponentSampleBufferReady(Sender: TObject;
      const ATime: TMediaTime);
    procedure btnMoreClick(Sender: TObject);
    procedure btnBaixaClick(Sender: TObject);
    procedure btnMediaClick(Sender: TObject);
    procedure btnAltaClick(Sender: TObject);
    procedure btnMaximaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnCameraClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmApplication: TfrmApplication;

implementation

{$R *.fmx}

procedure TfrmApplication.btnAltaClick(Sender: TObject);
  begin
    MudaQualidade(TVideoCaptureQuality.HighQuality);
    {$IFDEF ANDROID}
      Toast('Qualidade Alta Selecionada');
    {$ENDIF ANDROID}
  end;

procedure TfrmApplication.btnBaixaClick(Sender: TObject);
  begin
    MudaQualidade(TVideoCaptureQuality.LowQuality);
    {$IFDEF ANDROID}
      Toast('Qualidade Baixa Selecionada');
    {$ENDIF ANDROID}
  end;

procedure TfrmApplication.btnCameraClick(Sender: TObject);
  begin
    CameraComponent.Active := true;
  end;

procedure TfrmApplication.btnMaximaClick(Sender: TObject);
  begin
    MudaQualidade(TVideoCaptureQuality.PhotoQuality);
    {$IFDEF ANDROID}
      Toast('Qualidade Máxima Selecionada');
    {$ENDIF ANDROID}
  end;

procedure TfrmApplication.btnMediaClick(Sender: TObject);
  begin
    MudaQualidade(TVideoCaptureQuality.MediumQuality);
    {$IFDEF ANDROID}
      Toast('Qualidade Média Selecionada');
    {$ENDIF ANDROID}
  end;

procedure TfrmApplication.btnMoreClick(Sender: TObject);
  begin
    if lbPopup.Visible = false then
      begin
        lbPopup.Visible := true;
      end

    else
      begin
        lbPopup.Visible := false;
      end;
  end;

procedure TfrmApplication.btnSairClick(Sender: TObject);
  begin
    Close();
  end;

procedure TfrmApplication.CameraComponentSampleBufferReady(Sender: TObject;
  const ATime: TMediaTime);
  begin
    TThread.Synchronize(TThread.CurrentThread, PegarImagem);
  end;

procedure TfrmApplication.FormShow(Sender: TObject);
  begin
    lbPopup.Visible := false;
    CameraComponent.Active := false;
  end;

procedure TfrmApplication.MudaQualidade(
  const NovaQualidade: TVideoCaptureQuality);
var CameraAtiva: boolean;
  begin
    CameraAtiva := CameraComponent.Active;
      try
        CameraComponent.Active := false;
        CameraComponent.Quality := NovaQualidade;
      finally
        CameraComponent.Active := CameraAtiva;
      end;
  end;

procedure TfrmApplication.PegarImagem;
  begin
    CameraComponent.SampleBufferToBitmap(imgCamera.Bitmap, true);
  end;

end.
