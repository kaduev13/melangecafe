unit SaleShot;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.StdCtrls,
	Vcl.OleServer, ExcelXP, Session, Good;

type
	TfmSaleShot = class(TForm)
		sgSess: TStringGrid;
		pnlBtns: TPanel;
		pnlGrid: TPanel;
		edtBaseName: TEdit;
		procedure sgSessClick(Sender: TObject);
	private
		FBaseName: string;
		Sessions: TSessionArray;
	private
//		function GetFieldFromArray(good: TGood; num: integer): string;
//		procedure GetGoodInfos(var goods: TGoodArray; ASessId: integer);
		procedure SetBaseName(value: string);
		procedure RefreshSess;
		procedure View;
		procedure DoSalesShot(ASessId: integer);
	public
		property BaseName: string read FBaseName write SetBaseName;
	end;

var
	fmSaleShot: TfmSaleShot;

implementation

uses
	db_comps_additional, System.Win.ComObj, vars, SessionRepository, GoodRepository;

var
	SGSESS_COL_COUNT: integer;
	SGSESS_COL_CAPS: array of string;
	SGSESS_COL_WIDTHS: array of integer;
	XL_COL_CAPS: array of string;
	XL_COL_WIDTHS: array of integer;
	XL_COL_COUNT: integer;
	SELECT_SQLS: array of string;

{$R *.dfm}

{ TfmSaleShot }

procedure TfmSaleShot.DoSalesShot(ASessId: integer);
type
	TRowInfo = record
		caption: string;
		price: string;
		amount: string;
		fake: string;
		actionAmount: string;
		discountAmount: string;
	end;

var
	adc: TDBCompsAddit;
	XLApp: ExcelApplication;
	i, j, o: integer;
	goods: TXLGoodArray;
	rowInfo: TRowInfo;
	y: integer;
	Sheet: ExcelWorksheet;

const
	lcid = LOCALE_USER_DEFAULT;

	procedure SetColWidth(ASheet: ExcelWorksheet; ACol, AWidth: integer);
	var
		oRng: ExcelRange;
	begin
		oRng := ASheet.Range[ASheet.Cells.Item[1, ACol], ASheet.Cells.Item[1, ACol]];
		oRng.EntireColumn.ColumnWidth := AWidth;
	end;

	procedure FillRow(ASheet: ExcelWorksheet; AY: integer; info: TRowInfo);
	var
		oRng: ExcelRange;
	begin
		ASheet.Cells.Item[AY, 1] := info.caption;
		oRng := ASheet.Range[
			ASheet.Cells.Item[AY, 1],
			ASheet.Cells.Item[AY + 1, 1]
		];
		oRng.Merge(False);
		oRng.VerticalAlignment := xlCenter;
		oRng.HorizontalAlignment := xlCenter;
		with ASheet.Cells do
		begin
			Item[AY, 2] := info.price.Replace(',', '.');
			Item[AY, 3] := info.amount.Replace(',', '.');
			Item[AY, 4] := info.discountAmount.Replace(',', '.');
			inc(AY);
			Item[AY, 2] := info.fake.Replace(',', '.');
			Item[AY, 3] := info.actionAmount.Replace(',', '.');
		end;
		oRng := ASheet.Range[
			ASheet.Cells.Item[AY - 1, 4],
			ASheet.Cells.Item[AY, 4]
		];
		oRng.Merge(False);
		oRng.VerticalAlignment := xlCenter;
		oRng.HorizontalAlignment := xlCenter;
	end;

begin
	XLApp := CreateOleObject('Excel.Application') as ExcelApplication;
	XLApp.Visible[lcid] := false;
	XLApp.SheetsInNewWorkbook[lcid] := 1;
	XLApp.WorkBooks.Add(EmptyParam, lcid);
	Sheet := XLApp.Workbooks[1].Worksheets[1] as ExcelWorksheet;
	for j := 0 to XL_COL_COUNT - 1 do
	begin
		SetColWidth(Sheet, j + 1, XL_COL_WIDTHS[j]);
	end;
	goods := TGoodRepository.GetForXL(FBaseName, ASessId);
	with rowInfo do
	begin
		caption := '������������';
		price := '�������';
		amount := '�������';
		discountAmount := '������';
		fake := '�������';
		actionAmount := '�����';
    end;
	y := 1;
	FillRow(Sheet, y, rowInfo);
	for i := 0 to high(goods) do
	begin
		inc(y, 2);
		with rowInfo do
		begin
			caption := goods[i].Caption;
			price := PriceToStr(goods[i].Price);
			amount := PriceToStr(goods[i].Sold + goods[i].SoldDiscount);
			discountAmount := PriceToStr(goods[i].SoldDiscount);
			fake := '0';
			actionAmount := PriceToStr(goods[i].SoldAction);
		end;
		FillRow(Sheet, y, rowInfo);
    end;
	for i := 0 to high(goods) do
	begin
		FreeAndNil(goods[i]);
	end;
	setlength(goods, 0);
	XLApp.Visible[lcid] := true;
end;

procedure TfmSaleShot.RefreshSess;
begin
	Sessions := TSessionRepository.GetAll(FBaseName);
	View;
end;

procedure TfmSaleShot.SetBaseName(value: string);
begin
	FBaseName := value;
	edtBaseName.Text := value;
	RefreshSess;
end;

procedure TfmSaleShot.sgSessClick(Sender: TObject);
var
   ARow: integer;
begin
	ARow := sgSess.Selection.Top;
	if ARow < 1 then
		Exit;
	DoSalesShot(Sessions[ARow - 1].Id);
end;

procedure TfmSaleShot.View;
var
	i: integer;
begin
	with sgSess do
	begin
		FixedCols := 0;
		ColCount := SGSESS_COL_COUNT;
		for i := 0 to SGSESS_COL_COUNT - 1 do
		begin
			Cells[i, 0] := SGSESS_COL_CAPS[i];
			ColWidths[i] := SGSESS_COL_WIDTHS[i];
		end;
		RowCount := 1;
		for i := 0 to High(Sessions) do
		begin
			RowCount := RowCount + 1;
			Cells[0, i + 1] := IntToStr(Sessions[i].id);
			Cells[1, i + 1] := DateTimeToStr(Sessions[i].dtStart);
			if Sessions[i].dtEnd = 0 then
				Cells[2, i + 1] := '�� ���������'
			else
				Cells[2, i + 1] := DateTimeToStr(Sessions[i].dtEnd);
		end;
	end;

end;

initialization
	SGSESS_COL_COUNT := 3;
	SetLength(SGSESS_COL_CAPS, SGSESS_COL_COUNT);
	SetLength(SGSESS_COL_WIDTHS, SGSESS_COL_COUNT);
	SGSESS_COL_CAPS[0] := '��';
	SGSESS_COL_CAPS[1] := '��������';
	SGSESS_COL_CAPS[2] := '�����������';
	SGSESS_COL_WIDTHS[0] := 50;
	SGSESS_COL_WIDTHS[1] := 150;
	SGSESS_COL_WIDTHS[2] := 150;
	XL_COL_COUNT := 4;
	SetLength(XL_COL_WIDTHS, XL_COL_COUNT);
	XL_COL_WIDTHS[0] := 40;
	XL_COL_WIDTHS[1] := 20;
	XL_COL_WIDTHS[2] := 20;
	XL_COL_WIDTHS[3] := 20;
//	SetLength(SELECT_SQLS, 2);
//	SELECT_SQLS[0] := 'SELECT DISTINCT g.id, g.caption, g.price, ' +
//						'(SELECT SUM(sg1.amount + sg1.action_amount) ' +
//						'FROM SALES s1 INNER JOIN SALE_GOODS sg1 ON ' +
//						's1.id = sg1.SALE_ID WHERE s1.SESS_ID = :sess_id ' +
//						'AND sg1.GOOD_ID = g.ID), ' +
//						'(SELECT SUM(sg1.action_amount) FROM SALES s1 ' +
//						'INNER JOIN SALE_GOODS sg1 ON s1.id = sg1.SALE_ID ' +
//						'WHERE s1.SESS_ID = :sess_id AND sg1.GOOD_ID = g.ID) FROM SALES ' +
//						's INNER JOIN SALE_GOODS sg ON s.id = sg.SALE_ID INNER ' +
//						'JOIN GOODS g ON sg.GOOD_ID = g.ID WHERE flag = :flag ORDER BY g.id '
end.
