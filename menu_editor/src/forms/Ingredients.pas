unit Ingredients;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Ingredient;

type
	TfmIngredients = class(TForm)
    sgIngredients: TStringGrid;
		pnlBtns: TPanel;
		btnEdit: TButton;
		btnCreate: TButton;
		btnDelete: TButton;
		procedure btnCreateClick(Sender: TObject);
		procedure btnDeleteClick(Sender: TObject);
		procedure btnEditClick(Sender: TObject);
	private
		items: TIngredientArray;
		BaseName: string;
		procedure resetItems();
	public
    	procedure prepare();
end;

procedure show(ABaseName: string);

var
	fmIngredients: TfmIngredients;

implementation

{$R *.dfm}

uses
	IngredientRepository, IngredientCard;

procedure show(ABaseName: string);
begin
	if (fmIngredients = nil) then
	begin
		fmIngredients := TfmIngredients.Create(nil);
	end;
	fmIngredients.BaseName := ABaseName;
	fmIngredients.prepare();
	fmIngredients.Show();
end;

{ TfmIngredients }

procedure TfmIngredients.btnCreateClick(Sender: TObject);
var
	Ingredient: TIngredient;
begin
	Ingredient := TIngredient.Create();
	if (IngredientCard.show(@Ingredient, BaseName)) then
	begin
		Ingredient.Insert(BaseName);
		resetItems();
	end;
end;

procedure TfmIngredients.btnDeleteClick(Sender: TObject);
var
	selected: integer;
begin
	selected := sgIngredients.Selection.Top;
	if (selected > 0) and (length(items) >= selected) then
	begin
		items[selected - 1].Delete(BaseName);
		resetItems();
    end;
end;

procedure TfmIngredients.btnEditClick(Sender: TObject);
var
	selected: integer;
begin
	selected := sgIngredients.Selection.Top;
	if (selected > 0) and (length(items) >= selected) then
	begin
		if (IngredientCard.show(@items[selected - 1], BaseName)) then
		begin
			items[selected - 1].Update(BaseName);
			resetItems();
        end;
    end;
end;

procedure TfmIngredients.prepare;
begin
	with sgIngredients do
	begin
		ColCount := 3;
		RowCount := 1;
		FixedCols := 1;
		Cells[0, 0] := 'Id';
		Cells[1, 0] := '��������';
		Cells[2, 0] := '��.���������';
		ColWidths[0] := 100;
		ColWidths[1] := 300;
		ColWidths[2] := 150;
	end;
	resetItems();
end;

procedure TfmIngredients.resetItems;
var
	i: integer;
begin
	sgIngredients.RowCount := 1;
	for i := 0 to high(items) do
	begin
		FreeAndNil(items[i]);
	end;
	setlength(items, 0);
	items := TIngredientRepository.GetAll(BaseName);
	for i := 0 to high(items) do
	begin
		with sgIngredients do
		begin
			RowCount := RowCount + 1;
			Cells[0, i + 1] := IntToStr(items[i].Id);
			Cells[1, i + 1] := items[i].Caption;
			Cells[2, i + 1] := items[i].Measure.Caption;
        end;
	end;
end;

end.
