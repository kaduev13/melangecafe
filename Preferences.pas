unit Preferences;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, vars, PlatformSizes;

type
  TfmPreferences = class(TForm)
    rbgKKMMode: TRadioGroup;
    rbgPlatformMode: TRadioGroup;
    btnOK: TButton;
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  fmPreferences: TfmPreferences;

implementation

{$R *.dfm}

procedure TfmPreferences.btnOKClick(Sender: TObject);
var
  KKMModeItemIndex, PlatformModeItemIndex: integer;
begin
  KKMModeItemIndex := rbgKKMMode.ItemIndex;
  PlatformModeItemIndex := rbgPlatformMode.ItemIndex;
  if ((KKMModeItemIndex < 0) or (KKMModeItemIndex > 1)) then
  begin
    ShowMessage('�������� ����� ������ � �������� ���������!');
    exit;
  end;
  if ((PlatformModeItemIndex < 0) or (PlatformModeItemIndex > 1)) then
  begin
    ShowMessage('�������� ��� ���������!');
    exit;
  end;
  KKM_MODE := TKKMMode(KKMModeItemIndex);
  PLATFORM_MODE := TPlatformMode(PlatformModeItemIndex);
  Sizes := TPlatformSizes.Create(PLATFORM_MODE);
  ModalResult := mrYes;
  CloseModal;
end;

end.
