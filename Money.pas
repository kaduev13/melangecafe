unit Money;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, vars;

type
  TfmMoney = class(TForm)
	lbledtsum: TLabeledEdit;
	lbledtin: TLabeledEdit;
	lbledtout: TLabeledEdit;
	btnOk: TButton;
	procedure lbledtinChange(Sender: TObject);
	procedure btnOkClick(Sender: TObject);
    procedure lbledtinClick(Sender: TObject);
  private
	{ Private declarations }
  public
	constructor Create(ASum: double);
  end;

implementation

{$R *.dfm}
uses
	ValInput;

{ TfmMoney }

procedure TfmMoney.btnOkClick(Sender: TObject);
begin
	ModalResult := mrOk;
   	CloseModal;
end;

constructor TfmMoney.Create(ASum: double);
begin
   inherited Create(nil);
   lbledtsum.Text := PriceToStr(ASum);
end;

procedure TfmMoney.lbledtinChange(Sender: TObject);
var
   a, b, c: double;
begin
   if lbledtin.Text = '' then
   begin
	  lbledtin.Text := '0';
	  lbledtin.SelStart := 1;
   end;

   try
	  a := StrToPrice(lbledtsum.Text);
	  b := StrToPrice(lbledtin.Text);
   except
	  on E:Exception do
	  begin
		 ShowMessage('������������ �����!');
		 Exit;
	  end;
   end;
   c := b - a;
   lbledtout.Text := PriceToStr(c);
end;

procedure TfmMoney.lbledtinClick(Sender: TObject);
var
	ns: string;
	a, b, c: double;
begin
	ns := GetText(true, '������ ��������:', '������� �����');
	try
		a := StrToPrice(ns);
		b := StrToPrice(lbledtsum.Text);
	except
		on E:Exception do
		begin
			ShowMessage('������������ �����!');
			lbledtin.Text := '';
			lbledtout.Text := '';
			exit;
		end;
	end;
	c := a - b;
	lbledtout.Text := PriceToStr(c);
	lbledtin.Text := ns;
end;

end.
