unit MeasureCard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Measure, Vcl.StdCtrls, Vcl.ExtCtrls;

type
	TfmMeasureCard = class(TForm)
    leCaption: TLabeledEdit;
    pnlBtns: TPanel;
    btnSave: TButton;
    btnCancel: TButton;
    procedure leCaptionClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
	private
	{ Private declarations }
	public
		PMeasure: TPMeasure;
		procedure prepare();
	{ Public declarations }
	end;

function show(APMeasure: TPMeasure): boolean;

var
  fmMeasureCard: TfmMeasureCard;

implementation

{$R *.dfm}

uses ValInput;

function show(APMeasure: TPMeasure): boolean;
begin
	if (fmMeasureCard = nil) then
	begin
        fmMeasureCard := TfmMeasureCard.Create(nil);
	end;
	fmMeasureCard.PMeasure := APMeasure;
	fmMeasureCard.prepare();
	fmMeasureCard.ShowModal();
	result := fmMeasureCard.ModalResult = mrOk;
end;

{ TfmMeasureCard }

procedure TfmMeasureCard.btnCancelClick(Sender: TObject);
begin
	ModalResult := mrCancel;
	CloseModal;
end;

procedure TfmMeasureCard.btnSaveClick(Sender: TObject);
begin
	PMeasure^.Caption := leCaption.Text;
	ModalResult := mrOk;
	CloseModal;
end;

procedure TfmMeasureCard.leCaptionClick(Sender: TObject);
var
	s: string;
begin
	s := GetText(false, '�������� ������� ���������', '������� ��������');
	leCaption.Text := s;
end;

procedure TfmMeasureCard.prepare;
begin
	leCaption.Text := PMeasure^.Caption;
end;

end.
