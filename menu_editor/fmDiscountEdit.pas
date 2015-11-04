unit fmDiscountEdit;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Discount;

type
	TfmDiscountEditor = class(TForm)
		lbDiscounts: TListBox;
		pnlTools: TPanel;
		btnAddDiscounts: TButton;
    procedure lbDiscountsClick(Sender: TObject);
    procedure btnAddDiscountsClick(Sender: TObject);
	private
		FBaseName: string;
		discounts: TDiscountSeriaBlockArray;
	public
		procedure prepare(ABaseName: string);
	end;

var
	fmDiscountEditor: TfmDiscountEditor;

implementation

{$R *.dfm}

uses DiscountRepository, DiscountCard;

{ TfmDiscountEditor }

procedure TfmDiscountEditor.btnAddDiscountsClick(Sender: TObject);
begin
	fmDiscountCard := TfmDiscountCard.Create(nil);
	fmDiscountCard.prepare(FBaseName);
	fmDiscountCard.ShowModal;
	FreeAndNil(fmDiscountCard);
	prepare(FBaseName);
end;

procedure TfmDiscountEditor.lbDiscountsClick(Sender: TObject);
begin
	if (lbDiscounts.ItemIndex < 0) then
		exit;
	fmDiscountCard := TfmDiscountCard.Create(nil);
	fmDiscountCard.prepare(FBaseName, discounts[lbDiscounts.ItemIndex]);
	fmDiscountCard.ShowModal;
	FreeAndNil(fmDiscountCard);
	prepare(FBaseName);
end;

procedure TfmDiscountEditor.prepare(ABaseName: string);
var
	i: integer;
begin
	FBaseName := ABaseName;
	setlength(discounts, 0);
	discounts := TDiscountRepository.GetSeriaBlocks(ABaseName);
	lbDiscounts.Items.Clear;
	for i := 0 to high(discounts) do
	begin
		lbDiscounts.AddItem(DiscountSeriaBlockToString(discounts[i]), nil);
    end;
end;

end.
