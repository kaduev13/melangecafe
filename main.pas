﻿unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.Menus,
  Vcl.StdCtrls, menuEdit, vars, System.Win.ComObj, Vcl.ComCtrls, CheckTab,
  SaleType, Vcl.Buttons, db_menu, Vcl.OleServer, Excel2000, Money, Data.DB,
  IBX.IBDatabase, db_procs, Preferences;

type
  TfmMain = class(TForm)
    mainmenu: TMainMenu;
    miFile: TMenuItem;
    miExit: TMenuItem;
    miSettings: TMenuItem;
    Help1: TMenuItem;
    pnlMenu: TPanel;
    pnlCount: TPanel;
    pnlBtns: TPanel;
    btnOk: TButton;
    btnDiscard: TButton;
    pnl: TPanel;
    splMain: TSplitter;
    DeviceSetup1: TMenuItem;
    shpSess: TShape;
    pgcCheck: TPageControl;
    btnAdd: TButton;
    miStatus: TMenuItem;
    miOps: TMenuItem;
    miIncome: TMenuItem;
    miOutcome: TMenuItem;
    btnReturn: TButton;
    btnBack: TBitBtn;
    btnRoot: TBitBtn;
    pnlMenuBtns: TPanel;
    edtPath: TEdit;
    shpDBSession: TShape;
    lbl1: TLabel;
    lbl2: TLabel;
    N1: TMenuItem;
    miKKMSess: TMenuItem;
    miSessDB: TMenuItem;
    miKKMSessInfo: TMenuItem;
    miKKMOpenSess: TMenuItem;
    miKKMCloseSess: TMenuItem;
    miOpenSess: TMenuItem;
    miDBCloseSess: TMenuItem;
    miDbStatus: TMenuItem;
    btnFakeOk: TButton;
    miHistory: TMenuItem;
    miXReport: TMenuItem;
    sbDBMenu: TScrollBox;
    N1001: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure btnDiscardClick(Sender: TObject);
    procedure Ok(Sender: TObject);
    procedure miExitClick(Sender: TObject);
    procedure DeviceSetup1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure shpSessMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnAddClick(Sender: TObject);
    procedure miStatusClick(Sender: TObject);
    procedure miOutcomeClick(Sender: TObject);
    procedure miIncomeClick(Sender: TObject);
    procedure btnReturnClick(Sender: TObject);
    procedure miKKMSessInfoClick(Sender: TObject);
    procedure miKKMOpenSessClick(Sender: TObject);
    procedure miKKMCloseSessClick(Sender: TObject);
    procedure miDbStatusClick(Sender: TObject);
    procedure miOpenSessClick(Sender: TObject);
    procedure miDBCloseSessClick(Sender: TObject);
    procedure shpDBSessionMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure miHistoryClick(Sender: TObject);
    procedure btnFakeOkClick(Sender: TObject);
    procedure miXReportClick(Sender: TObject);
  private
    checks: array of TCheckTab;
    mainViewMenu: TDBViewMenu;
    procedure DriverInit;
    function GetNewIdx: integer;
    function GetActivePageArrIdx: integer;
    procedure FreeTab(AIdx: integer);
  private
    function EnterRegMode: boolean;
    function UpdateStatus: boolean;
    function AllowActions: boolean;
  private
    procedure DBSessInfo;
    procedure DBOpenSess;
    procedure DBCloseSess;
    procedure DBIncome(summ: double);
  private
    procedure AddGood(id: integer; caption: string; price: double; actionAble: boolean);
    procedure KKMSessInfo;
    procedure KKMOpenSess;
    procedure KKMCloseSess;
    function KKMIncome: double;
    function KKMOutcome: double;
  public
	function DoPrint(ASg: TStringGrid; ASaleType: integer; returnIt: boolean;
      ATabIdx: integer; discount: TDiscount): Boolean;
//    procedure gridClick(Sender: TObject);
  end;



var
  fmMain: TfmMain;
  ECR: OleVariant;
const DEBUG = false;
const KKM_WORK = true;

procedure ShowError(AMessage: string);

implementation

uses
  history, db_comps_additional, PlatformSizes, ValInput;

{$R *.dfm}

function TfmMain.UpdateStatus: boolean;
begin
   if not KKM_WORK then
   begin
      result := true;
      exit;
   end;
   if ECR.GetStatus <> 0 then
   begin
      ShowError('Не удалось обновить информацию об устройстве!');
      result := false;
      Exit;
   end;
   result := true;
end;

function TfmMain.EnterRegMode: boolean;
begin
   if not KKM_WORK then
   begin
      result := true;
      exit;
   end;
   ECR.Password := '30';
   ECR.Mode := 1;
   if ECR.SetMode <> 0 then
   begin
      ShowError('');
      result := false;
      exit;
   end;
   result := True;
end;

procedure ShowError(AMessage: string);
begin
   Application.MessageBox(PWideChar(AMessage), PChar(Application.Title), MB_ICONERROR + MB_OK);
end;

procedure TfmMain.AddGood(id: integer; caption: string; price: double;
  actionAble: boolean);
var
   ns: string;
   n: double;
   na: double;
   last: integer;
   tabIdx: integer;
   sgCount: TStringGrid;
   summ: double;
begin
   n := 0;
   na := 0;
   tabIdx := GetActivePageArrIdx;
   if tabIdx < 0 then
      Exit;
   sgCount := checks[tabIdx].grid;
   ns := GetText(true, 'Введите количество!', 'Количество без акции:');
   try
      n := StrToPrice(ns);
   except
      on E:Exception do
	  begin
	  	n := 0;
//         ShowMessage('Введено не корректное количество товара.');
//         exit;
      end;
   end;
   if n < 0 then
   begin
      ShowMessage('Количество не может быть отрицательным!');
      exit;
   end;
   if actionAble then
   begin
      ns := GetText(true, 'Введите количество!', 'Количество с акцией:');
      try
         na := StrToPrice(ns);
      except
         on E:Exception do
		 begin
		 	na := 0;
//            ShowMessage('Введено не корректное количество товара.');
//            exit;
		 end;
      end;
      if na < 0 then
      begin
         ShowMessage('Количество не может быть отрицательным!');
         exit;
      end;
   end;
   if n + na = 0 then
      exit;
   sgCount.RowCount := sgCount.RowCount + 1;
   last := sgCount.RowCount - 1;
   checks[tabIdx].AddGoodInfo(id, n, na, actionAble);
   with sgCount do
   begin
	  Cells[0, last] := caption;
      Cells[1, last] := PriceToStr(price);
      Cells[2, last] := PriceToStr(n);
      Cells[3, last] := PriceToStr(na);
      Cells[4, last] := PriceToStr(n * price);
   end;
   summ := StrToPrice(checks[tabIdx].edtSumm.Text);
   summ := summ + n * price;
   checks[tabIdx].edtSumm.Text := PriceToStr(summ);
end;

function TfmMain.AllowActions: boolean;
var
   fKKM: boolean;
   fDB: boolean;
begin
   result := false;
   fKKM := false;
   fDB := false;
   if ((not KKM_WORK) or (KKM_MODE = TKKMModeNO)) then
      fKKM := true
   else
   begin
      if not ECR.DeviceEnabled then
      begin
         ShowMessage('Устройство не подключено. Подключение...');
         ECR.DeviceEnabled := true;
         if ECR.ResultCode <> 0 then
         begin
            ShowError('Не удается подключить устройство!');
            fKKM := false;
            result := False;
            Exit;
         end;
      end;
      if not UpdateStatus then
      begin
         Result := false;
         Exit;
      end;
      if ECR.GetCurrentMode <> 0 then
      begin
         ShowError('Не удается получить статус!');
         Result := false;
         Exit;
      end;
      if ECR.Mode <> 1 then
      begin
         ECR.Mode := 1;
         ECR.Password := '';
         if ECR.SetMode <> 0 then
         begin
            ShowError('Не удается перевести ККМ в режим продаж!');
            result := false;
            Exit;
         end;
      end;
      fKKM := true;
   end;
   if SESS_ID > 0 then
      fDB := true;
   result := fKKM and fDB;
end;

procedure TfmMain.btnAddClick(Sender: TObject);
var
   idx: integer;
begin
   idx := GetNewIdx;
   checks[idx] := TCheckTab.Create(pgcCheck, idx);
   pgcCheck.ActivePageIndex := pgcCheck.PageCount - 1;
//   with checks[idx].grid do
//   begin
//      OnClick := gridClick;
//   end;
end;

procedure TfmMain.btnDiscardClick(Sender: TObject);
var
   idx: integer;
begin
   idx := GetActivePageArrIdx;
   if (idx < 0) or (idx > high(checks)) then
      exit;
   FreeTab(checks[GetActivePageArrIdx].tab.PageIndex);
end;

procedure TfmMain.btnFakeOkClick(Sender: TObject);
var
   idx: integer;
   i: integer;
   str: string;
begin
   if not AllowActions then
   begin
      ShowMessage('Невозможно выполнить операцию! Проверьте сессии!');
      Exit;
   end;
   idx := GetActivePageArrIdx;
   if idx < 0 then
      exit;
   if not KKM_WORK then
   begin
      ShowMessage('Данная версия программы не позволяет работать с KKM');
      Exit;
   end;
   if not ECR.DeviceEnabled then
   begin
      ShowError('Устройство выключено');
      Exit;
   end;
   if not UpdateStatus then
   begin
      ShowError('Не удается обновить статус устройства!');
      Exit;
   end;
   with checks[idx] do
   begin
      if length(goods) = 0 then
         Exit;
      if not EnterRegMode then
         Exit;
      ECR.SlipDocCharLineLength := 40;
      ECR.SlipDocTopMargin := 2;
      ECR.SlipDocLeftMargin := 1;
      ECR.SlipDocOrientation := 0;
      ECR.BeginDocument;
      for i := 0 to high(goods) do
      begin
         Str := grid.Cells[0, i + 1] + ' ' + PriceToStr(goods[i].amount) +
         ' X ' + grid.Cells[1, i + 1] + ' = ' + grid.Cells[4, i + 1];
         ECR.Alignment := 0;
         ECR.Caption := Str;
         ECR.TextWrap := 2;
         if ECR.PrintString <> 0 then
            exit;
      end;
      ECR.Caption := 'Итог: ' + edtSumm.Text;
      if ECR.PrintString <> 0 then
         exit;
      ECR.PrintHeader;
      if ECR.PartialCut <> 0 then
         exit;
      ECR.EndDocument;
   end;
end;

procedure TfmMain.btnReturnClick(Sender: TObject);
var
   idx: integer;
begin
   idx := GetNewIdx;
   checks[idx] := TCheckTab.Create(pgcCheck, pgcCheck.PageCount);
   pgcCheck.ActivePageIndex := pgcCheck.PageCount - 1;
   checks[idx].SetReturned;
end;

procedure TfmMain.Ok(Sender: TObject);
var
   tabIdx: integer;
   saleType: integer;
   fmMoney: TfmMoney;
   disSS: string;
   disNS: string;
   disS: integer;
   disN: integer;
   discount: TDiscount;
   tmp: double;
begin
   discount.id := 0;
   discount.amount := 0;
   if not AllowActions then
   begin
      ShowMessage('Невозможно закрыть чек, проверьте сессии.');
      Exit;
   end;
   tabIdx := GetActivePageArrIdx;
   if tabIdx = -1 then
      exit;
   if (tabIdx > high(checks)) then
      Exit;
   if (checks[tabIdx] = nil) then
      exit;
   if length(checks[tabIdx].goods) = 0 then
   begin
      FreeTab(checks[GetActivePageArrIdx].tab.PageIndex);
      Exit;
   end;
   if (checks[tabIdx].isReturn) then
      saleType := 0
   else
   begin
      fmSaleType.prepare(StrToPrice(checks[tabIdx].edtSumm.Text));
      fmSaleType.ShowModal;
	  saleType := fmSaleType.lastDecision;
	  discount := fmSaleType.discount;
      if saleType < 0 then
         exit;
      if saleType = 0 then
      begin
         tmp := StrToPrice(checks[tabIdx].edtSumm.Text);
         tmp := tmp * (100 - discount.amount) / 100;
         fmMoney := TfmMoney.Create(tmp);
		 if (fmMoney.ShowModal <> mrOk) then
		 begin
			 FreeAndNil(fmMoney);
			 ShowMessage('Продажа была отменена!');
			 exit;
		 end;
		 FreeAndNil(fmMoney);
      end;
   end;
   if length(checks[tabIdx].goods) = 0 then
      exit;
   if DoPrint(checks[tabIdx].grid, saleType, checks[tabIdx].isReturn, tabIdx, discount) then
      FreeTab(checks[GetActivePageArrIdx].tab.PageIndex);
end;

procedure TfmMain.DBCloseSess;
begin
   if TDbProcs.CloseSession then
   begin
      ShowMessage('Сессия БД закрыта успешно.');
      shpDBSession.Brush.Color := clRed;
   end
   else
      ShowMessage('Не удалось закрыть сессию БД');
end;

procedure TfmMain.DBIncome(summ: double);
begin
   TDbProcs.CashActions(summ, 1);
end;

procedure TfmMain.DBOpenSess;
begin
   if TDbProcs.OpenSession then
   begin
      ShowMessage('Сессия БД открыта успешно.');
      shpDBSession.Brush.Color := clGreen;
   end
   else
      ShowMessage('Не удалось открыть сессию БД');
end;

procedure TfmMain.DBSessInfo;
begin
   if (SESS_ID = -1) then
   begin
      ShowMessage('Сессия БД не была инициализированна. Произошел сбой.');
      exit;
   end;
   if (SESS_ID = 0) then
   begin
      ShowMessage('Последняя сессия БД не была найдена.');
      exit;
   end;
   if (SESS_ID = -2) then
   begin
      ShowMessage('Последняя сессия была закрыта. Ожидание открытия новой сессии.');
      shpDBSession.Brush.Color := clRed;
      Exit;
   end
   else
   begin
      ShowMessage('Сессия БД открыта.');
      shpDBSession.Brush.Color := clGreen;
      Exit;
   end;
end;

procedure TfmMain.DeviceSetup1Click(Sender: TObject);
begin
   ECR.ShowProperties;
end;

function TfmMain.DoPrint(ASg: TStringGrid; ASaleType: integer; returnIt: boolean;
   ATabIdx: integer; discount: TDiscount): Boolean;
var
   i: integer;
   summ: double;
   tmpRes, hasDiscount: boolean;
   goodName: string;
   goodAmount, goodActionAmount, goodPrice: double;
begin
   if SESS_ID = 0 then
   begin
      ShowMessage('Сессия в базе данных не инициализированна. Не удалось совершить продажу.');
      Exit;
   end;
   if (not KKM_WORK) or (KKM_MODE = TKKMModeNO) then
   begin
	  if (not KKM_WORK) then
	  begin
		ShowMessage('Данная версия программы не позволяет работать с KKM.');
	  end;
	  if TDbProcs.RegisterSale(ASaleType, checks[ATabIdx], discount) then
	  begin
		 ShowMessage('Операция выполнена!');
		 result := true;
      end
      else
      begin
         ShowMessage('Продажа выполнена, но не занесена в базу. Сохраните копию чека.');
         Result := false;
      end;
      Exit;
   end;

   //KKM PART
   summ := 0;
   if not ECR.DeviceEnabled then
   begin
      ShowMessage('Устройство не подключено. Подключение...');
      ECR.DeviceEnabled := true;
      if ECR.ResultCode <> 0 then
      begin
		 ShowError('Не удается подключить устройство!');
         Exit;
      end;
   end;
   if not UpdateStatus then
      Exit;
   if ECR.GetCurrentMode <> 0 then
   begin
      ShowError('Не удается получить статус!');
      Exit;
   end;
   if ECR.Mode <> 1 then
   begin
      ECR.Mode := 1;
      ECR.Password := '';
      if ECR.SetMode <> 0 then
      begin
         ShowError('Не удается перевести ККМ в режим продаж!');
         Exit;
      end;
   end;
   if ECR.CheckState <> 0 then
   begin
	 ShowMessage('Had opened check. Deleting...');
	 if ECR.CancelCheck <> 0 then
	 begin
	   ShowMessage('Cannt delete check. Exit.');
	   Exit;
	 end;
   end;
   for i := 1 to ASg.RowCount - 1 do
   begin
	  goodName := ASg.Cells[0, i];
	  goodPrice := StrToPrice(ASg.Cells[1, i]);
	  goodAmount := StrToPrice(ASg.Cells[2, i]);
	  goodActionAmount := StrToPrice(ASg.Cells[3, i]);
	  hasDiscount := (discount.id < 0) and (discount.key <> '');
	  if (goodAmount > 0) then
	  begin
		  ECR.Name := goodName;
		  ECR.Price := goodPrice;
		  ECR.Quantity := goodAmount;
		  if hasDiscount then
		  begin
			  ECR.DiscountType := 1;
			  ECR.DiscountValue := 10;
		  end else
		  begin
			ECR.DiscountType := 1;
			ECR.DiscountValue := 0;
		  end;;
		  if returnIt then
			 tmpRes := ECR.Return <> 0
		  else
			 tmpRes := ECR.Registration <> 0;
		  if tmpRes then
		  begin
			 ShowError('Не удалось зарегистрировать действие!');
			 Exit;
		  end;
	  end;
	  if (goodActionAmount > 0) then
	  begin
		ECR.Name := goodName;
		ECR.Price := goodPrice;
		ECR.Quantity := goodActionAmount;
		ECR.DiscountType := 1;
		ECR.DiscountValue := 100;
		  if returnIt then
			 tmpRes := ECR.Return <> 0
		  else
			 tmpRes := ECR.Registration <> 0;
		  if tmpRes then
		  begin
			 ShowError('Не удалось зарегистрировать действие!');
			 Exit;
		  end;
	  end;


	  summ := summ + goodAmount * goodPrice;
   end;
   ECR.Summ := summ;
   ECR.TypeClose := ASaleType;
   if returnIt then
	  ECR.CheckType := 2
   else
	  ECR.CheckType := 1;
   tmpRes := (ECR.CloseCheck = 0);
   if (not tmpRes) then
   begin
	  ShowError('Не удалось выполнить операцию!');
	  ECR.CancelCheck;
	  Exit;
   end;
   if TDbProcs.RegisterSale(ASaleType, checks[ATabIdx], discount) then
	  ShowMessage('Операция выполнена!')
   else
	  ShowMessage('Продажа выполнена, но не занесена в базу. Сохраните копию чека.');
   result := True;
end;

procedure TfmMain.DriverInit;
begin
   if not KKM_WORK then
      exit;
   try
      ECR := CreateOleObject('AddIn.FprnM45');
      ECR.ApplicationHandle := Application.Handle;
      ECR.ShowProperties;
      ECR.DeviceEnabled := true;
      if ECR.ResultCode <> 0 then
      begin
         ShowError('Не удалось инициализировать устройство!');
         Application.Terminate;
      end;
      // получаем состояние ККМ
      if ECR.GetStatus <> 0 then
      begin
         ShowError('Не удалось получить состояние устройства!');
         Application.Terminate;
      end;
   except
      on E:Exception do
      begin
         ShowError('Не удалось создать объект общего драйвера ККМ!');
         Application.Terminate;
      end;
   end;
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
   k: integer;
begin
   k := 0;
   if KKM_WORK and (KKM_MODE = TKKMModeYES) then
   begin
      ECR.DeviceEnabled := false;
      ECR := 0;
   end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
var
   fmPreferences: TfmPreferences;
   event: TGoodClickEvent;
begin
   event := AddGood;
   //определяем настройки
   fmPreferences := TfmPreferences.Create(nil);
   fmPreferences.ShowModal;

   mainViewMenu := TDBViewMenu.Create('kkm_base.fdb', btnBack, btnRoot, sbDBMenu, edtPath, event);
   if not TDbProcs.InitSession then
   begin
      ShowMessage('Не удается инициализировать БД. Выход из программы.');
      Application.Terminate;
   end;
   if (SESS_ID = 0) then
   begin
      ShowMessage('Не найдена информация о сессии (в БД). Это сообщение должно появиться при первом запуске ' +
                  'программы. Если оно появляется в дальнейшем - сообщите об этом тех.специалисту.');
   end;

   //размеры
   fmMain.Width := Sizes.fmMainWidth;
   fmMain.Height := Sizes.fmMainHeight;
   pnlMenu.Width := Sizes.fmMainWidth div 2;
   //элементы
   case PLATFORM_MODE of
      TPlatformModePC:
      begin
      end;
      TPlatformModeTablet:
      begin
        edtPath.Visible := false;
      end;
   end;
   //ккм
   case KKM_MODE of
      TKKMModeYES:
      begin
      end;
      TKKMModeNO:
      begin
        //hide sessions shapes
        shpSess.Visible := false;
        shpSess.Enabled := false;
        lbl1.Visible := false;
        lbl1.Enabled := false;
        //main menu work
        miXReport.Enabled := false;
        miStatus.Enabled := false;
        miKKMSess.Enabled := false;
        miKKMSessInfo.Enabled := false;
        miKKMOpenSess.Enabled := false;
        miKKMCloseSess.Enabled := false;
        miOps.Enabled := false;
        miOutcome.Enabled := false;
        miIncome.Enabled := false;
        miSettings.Enabled := false;
        DeviceSetup1.Enabled := false;
        //btns work
        btnFakeOk.Enabled := false;
        btnFakeOk.Visible := false;
        btnReturn.Enabled := false;
        btnReturn.Visible := false;
        //positions
        shpDBSession.Left := Sizes.margin;
        lbl2.Left := Sizes.margin;
        //btns
		pnlBtns.Height := Sizes.btnCtrlHeight + 10;
	  end;
   end;
   btnOk.Font.Size := Sizes.btnFontSize;
   btnAdd.Font.Size := Sizes.btnFontSize;
   btnDiscard.Font.Size := Sizes.btnFontSize;
   btnReturn.Font.Size := Sizes.btnFontSize;
   btnBack.Font.Size := Sizes.btnFontSize;
   btnFakeOk.Font.Size := Sizes.btnFontSize;
   btnRoot.Font.Size := Sizes.btnFontSize;
   if (KKM_MODE = TKKMModeYES) then
   begin
     DriverInit;
   end;
end;   

procedure TfmMain.FreeTab(AIdx: integer);
var
   tabTag, i: integer;
begin
   //
   if AIdx < 0 then
      Exit;
   tabTag := pgcCheck.Pages[AIdx].Tag;
   for i := 0 to high(checks) do
   begin
      if checks[i] = nil then
         Continue;
      if checks[i].tab.Tag = tabTag then
      begin
         checks[i].Destroy;
         checks[i] := nil;
         if i = high(checks) then
            SetLength(checks, length(checks) - 1);
         Exit;
      end;
   end;
end;

function TfmMain.GetActivePageArrIdx: integer;
var
   i: integer;
   pgcIdx: integer;
begin
   result := -1;
   if pgcCheck.PageCount = 0 then
      Exit;
   pgcIdx := pgcCheck.ActivePage.Tag;
   if pgcIdx < 0 then
      Exit;
   for i := 0 to high(checks) do
   begin
      if checks[i] = nil then
         Continue;
      if checks[i].tab.tag = pgcIdx then
      begin
         Result := i;
         Exit;
      end;
   end;
end;

function TfmMain.GetNewIdx: integer;
var
   i: integer;
begin
   for i := 0 to high(checks) do
      if checks[i] = nil then
      begin
         Result := i;
         Exit;
      end;
   setlength(checks, length(checks) + 1);
   result := high(checks);
end;

procedure TfmMain.KKMCloseSess;
begin
   if (KKM_MODE = TKKMModeNO) then
   begin
     Exit;
   end;
   if not KKM_WORK then
   begin
      ShowMessage('Данная версия программы не позволяет работать с ККМ.');
      Exit;
   end;

   ECR.Password := '30';
   ECR.Mode := 3;
   if ECR.SetMode <> 0 then
   begin
      ShowError('Не удается перевести ККМ в нужное состояние!');
      Exit;
   end;
   ECR.ReportType := 1;
   if ECR.Report <> 0 then
   begin
      ShowError('Не удалось напечатать Z-отчет!');
      ShowMessage('Сессия не закрыта!');
      Exit;
   end;
   shpSess.Brush.Color := clRed
end;

function TfmMain.KKMIncome: double;
var
   summ: double;
   tmp: string;
begin
   if (KKM_MODE = TKKMModeNO) then
   begin
     Exit;
   end;

   summ := 0;
   tmp := '';
   if not InputQuery('Введите сумму', 'Внесенная сумма', tmp) then
   begin
      ShowMessage('Введена некорректная сумма!');
      exit;
   end;
   try
      summ := StrToPrice(tmp);
   except
      on E:Exception do
      begin
         ShowMessage('Введена не корректная сумма!');
         result := -1;
         exit;
      end;
   end;
   if not UpdateStatus then
      exit;
   ECR.TestMode := DEBUG;
   ECR.Summ := summ;
   ECR.CashIncome;
   result := summ;
end;

procedure TfmMain.KKMOpenSess;
begin
   if (KKM_MODE = TKKMModeNO) then
   begin
     ShowMessage('Работа с кассовым аппаратом отключена в настройках');
     Exit;
   end;
   if not KKM_WORK then
   begin
      ShowMessage('Данная версия программы не позволяет работать с ККМ.');
      Exit;
   end;
   if not EnterRegMode then
   begin
      ShowMessage('Не удается открыть сессию!');
   end;
   ECR.Password := '';
   ECR.Caption := 'Сессия KKM открыта!';
   ECR.TestMode := DEBUG;
   if ECR.OpenSession <> 0 then
   begin
      ShowError('Не удается открыть сессию!');
      Exit;
   end;
   shpSess.Brush.Color := clGreen
end;

function TfmMain.KKMOutcome: double;
var
   tmp: string;
   summ: double;
begin
   if (KKM_MODE = TKKMModeNO) then
   begin
     ShowMessage('Работа с кассовым аппаратом отключена в настройках');
     Exit;
   end;
   tmp := '';
   summ := 0;
   if not InputQuery('Введите сумму', 'Сумма для инкассации', tmp) then
   begin
      ShowMessage('Введена некорректная сумма!');
      exit;
   end;
   try
      summ := StrToPrice(tmp);
   except
      on E:Exception do
      begin
         ShowMessage('Введено не корректная сумма!');
         result := -1;
         exit;
      end;
   end;
   if not UpdateStatus then
      exit;
   ECR.TestMode := DEBUG;
   ECR.Summ := summ;
   ECR.CashOutcome;
   result := summ;
end;

procedure TfmMain.KKMSessInfo;
begin
   if (KKM_MODE = TKKMModeNO) then
   begin
     shpSess.Brush.Color := clYellow;
     ShowMessage('Программа работает в режиме без кассового аппарата');
     Exit;
   end;
   
   if not KKM_WORK then
   begin
      ShowMessage('Данная версия программы не позволяет работать С ККМ.');
      Exit;
   end;
   if not ECR.DeviceEnabled then
      ECR.DeviceEnabled := true;
   if not UpdateStatus then
      Exit;
   if ECR.SessionOpened then
   begin
      shpSess.Brush.Color := clGreen;
      ShowMessage('Состояние сессии ККМ: открыта.')
   end
   else
   begin
      shpSess.Brush.Color := clRed;
      ShowMessage('Состоянние сессии ККМ: закрыта.');
   end;
end;

procedure TfmMain.miDBCloseSessClick(Sender: TObject);
begin
   DBCloseSess;
end;

procedure TfmMain.miDbStatusClick(Sender: TObject);
begin
   DBSessInfo;
end;

procedure TfmMain.miExitClick(Sender: TObject);
begin
   Application.Terminate;
end;

procedure TfmMain.miHistoryClick(Sender: TObject);
var
   fmHistory: TfmHistory;
   s: string;
begin
   InputQuery('KKM_WISP', 'Введите пароль администратора!', s);
   if s <> 'admin_pass' then
      Exit;
   fmHistory := TfmHistory.Create;
   fmHistory.ShowModal;
end;

procedure TfmMain.miIncomeClick(Sender: TObject);
var
tmp: string;
summ: double;
begin
   summ := 0;
   if AllowActions then
   begin
      if KKM_WORK then
         summ := KKMIncome;
      if summ <= 0 then
         exit;
      DBIncome(summ);
      ShowMessage('Внесение суммы завершено!');
   end;
end;

procedure TfmMain.miOpenSessClick(Sender: TObject);
begin
   DBOpenSess;
end;

procedure TfmMain.miOutcomeClick(Sender: TObject);
var
   tmp: string;
   summ: Double;
begin
   summ := 0;
   if AllowActions then
   begin
      if KKM_WORK then
         summ := KKMOutcome;
      if summ <= 0 then
         exit;
      DBIncome(summ);
      ShowMessage('Внесение суммы завершено!');
   end;
end;

procedure TfmMain.miStatusClick(Sender: TObject);
begin
   if not KKM_WORK then
   begin
      ShowMessage('Данная версия программы не поддерживает работу с ККМ.');
      Exit;
   end;
   if (KKM_MODE = TKKMModeNO) then
   begin
     ShowMessage('Работа с ККМ отключена в настройках!');
     Exit;
   end;
   if (ECR.GetCurrentMode <> 0) then
   begin
      ShowMessage('Не удается получить информацию о текущем состоянии устройства!');
      Exit;
   end;
   ShowMessage('Текущий режим: ' + IntToStr(ECR.Mode));
end;

procedure TfmMain.miXReportClick(Sender: TObject);
begin
//
   if (not KKM_WORK) then
   begin
     ShowMessage('Данная версия программы не позволяет работать с кассовым аппаратом!');
     Exit;
   end;
   if (KKM_MODE = TKKMModeNO) then
   begin
     ShowMessage('Работа с ККМ отключена в настройках!');
     Exit;
   end;
   if not ECR.DeviceEnabled then
      ECR.DeviceEnabled := true;
   if not UpdateStatus then
   begin
      ShowMessage('Не удается обновить состояние ККМ');
      exit;
   end;
   ECR.Password := '30';
   ECR.Mode := 2;
   if ECR.SetMode <> 0 then
   begin
      ShowError('Не удается перевести ККМ в нужное состояние!');
      Exit;
   end;
   ECR.ReportType := 2;
   if ECR.Report <> 0 then
   begin
      ShowError('Не удалось напечатать X-отчет!');
      Exit;
   end;
end;

procedure TfmMain.miKKMCloseSessClick(Sender: TObject);
begin
   KKMCloseSess;
end;

procedure TfmMain.miKKMOpenSessClick(Sender: TObject);
begin
   KKMOpenSess;
end;

procedure TfmMain.miKKMSessInfoClick(Sender: TObject);
begin
   KKMSessInfo;
end;


procedure TfmMain.shpDBSessionMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   DBSessInfo;
end;

procedure TfmMain.shpSessMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   KKMSessInfo;
end;

end.
