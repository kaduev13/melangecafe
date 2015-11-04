unit goodCard;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Good,
	Vcl.Grids, Recipe;

type
	TfmGoodCard = class(TForm)
		edtName: TLabeledEdit;
		edtPrice: TLabeledEdit;
		cbActionAble: TCheckBox;
		btnDelete: TButton;
		btnCancel: TButton;
		btnSave: TButton;
		cbFlag: TComboBox;
		pnlBtns: TPanel;
		pnlGoodInfo: TPanel;
		pnlRecipe: TPanel;
		pnlRecipeBtns: TPanel;
		btnRecipeCreate: TButton;
		btnRecipeDelete: TButton;
		btnRecipeEdit: TButton;
		sgRecipes: TStringGrid;
		procedure btnSaveClick(Sender: TObject);
		procedure btnDeleteClick(Sender: TObject);
		procedure resetRecipes();
		procedure btnRecipeCreateClick(Sender: TObject);
		procedure btnRecipeDeleteClick(Sender: TObject);
    	procedure btnRecipeEditClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
		{ Private declarations }
	public
		recipes: TRecipeArray;
		goodRef: TPGood;
		BaseName: string;
		{ Public declarations }
	end;

var
	fmGoodCard: TfmGoodCard;

procedure editGood(AGoodRef: TPGood; ABaseName: string);

implementation

uses vars, RecipeRepository, RecipeCard;

{$R *.dfm}

procedure editGood(AGoodRef: TPGood; ABaseName: string);
var
	AGood: TGood;
begin
	AGood := AGoodRef^;
	with fmGoodCard do
	begin
		goodRef := AGoodRef;
		BaseName := ABaseName;
	end;
	if (AGood.id <> -1) then
	begin
		with fmGoodCard do
		begin
			edtName.Text := AGood.caption;
			edtPrice.Text := PriceToStr(AGood.price);
			cbActionAble.Checked := AGood.onAction = 1;
			cbFlag.ItemIndex := AGood.flag - 1;
			btnDelete.Visible := true;
			pnlRecipe.Enabled := true;
			with fmGoodCard.sgRecipes do
			begin
				RowCount := 1;
				ColCount := 4;
				FixedCols := 1;
				Cells[0, 0] := 'Id';
				Cells[1, 0] := '����������';
				Cells[2, 0] := '����������';
				Cells[3, 0] := '��. ���������';
				ColWidths[0] := 50;
				ColWidths[1] := 200;
				ColWidths[2] := 150;
				ColWidths[3] := 150;
			end;
			fmGoodCard.resetRecipes();
		end;
 	end
	else
	begin
		with fmGoodCard do
		begin
			pnlRecipe.Enabled := false;
			edtName.Text := '';
			edtPrice.Text := '';
			cbActionAble.Checked := false;
			cbFlag.ItemIndex := 0;
			btnDelete.Visible := false;
		end;
	end;
	fmGoodCard.ShowModal;
end;

procedure TfmGoodCard.btnCancelClick(Sender: TObject);
begin
	Close;
end;

procedure TfmGoodCard.btnDeleteClick(Sender: TObject);
begin
	if (goodRef^.Disable(BaseName)) then
	begin
		ShowMessage('����� ������� ���� � �������!');
		Close;
		Exit;
	end;
end;

procedure TfmGoodCard.btnRecipeCreateClick(Sender: TObject);
var
	Recipe: TRecipe;
begin
	Recipe := TRecipe.Create(
		TGood.Create(goodRef^.Id)
	);
	if (RecipeCard.show(@Recipe, BaseName)) then
	begin
	   Recipe.Insert(BaseName);
	   resetRecipes();
	end;
end;

procedure TfmGoodCard.btnRecipeDeleteClick(Sender: TObject);
var
	selected: integer;
begin
	selected := sgRecipes.Selection.Top;
	if (selected > 0) and (length(recipes) >= selected) then
	begin
		recipes[selected - 1].Delete(BaseName);
		resetRecipes();
    end;
end;

procedure TfmGoodCard.btnRecipeEditClick(Sender: TObject);
var
	selected: integer;
begin
	selected := sgRecipes.Selection.Top;
	if (selected > 0) and (length(recipes) >= selected) then
	begin
		if (RecipeCard.show(@recipes[selected - 1], BaseName)) then
		begin
			recipes[selected - 1].Update(BaseName);
			resetRecipes();
        end;
    end;
end;

procedure TfmGoodCard.btnSaveClick(Sender: TObject);
begin
	with goodRef^ do
	begin
		Caption := edtName.Text;
		Price := StrToPrice(edtPrice.Text);
		if (cbActionAble.Checked) then
			OnAction := 1
		else
			OnAction := 0;
		if (cbFlag.ItemIndex >= 0) then
			Flag := cbFlag.ItemIndex + 1;
	end;
	if (goodRef^.SaveUpdate(BaseName)) then
	begin
		ShowMessage('����� ��������!');
		Close;
		Exit;
	end;
end;

procedure TfmGoodCard.resetRecipes;
var
	i: integer;
begin
	for i := 0 to high(recipes) do
	begin
		FreeAndNil(recipes[i]);
	end;
	setlength(recipes, 0);
	recipes := TRecipeRepository.GetAllForGood(BaseName, goodRef^.Id);
	with sgRecipes do
	begin
		RowCount := 1;
		for i := 0 to high(recipes) do
		begin
			RowCount := RowCount + 1;
			Cells[0, i + 1] := IntToStr(recipes[i].Id);
			Cells[1, i + 1] := recipes[i].Ingredient.Caption;
			Cells[2, i + 1] := AmountToStr(recipes[i].Amount);
			Cells[3, i + 1] := recipes[i].Ingredient.Measure.Caption;
		end;
	end;
end;

end.
