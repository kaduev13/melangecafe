unit PlatformSizes;

interface
type
   TPlatformMode = (TPlatformModeUnknown = -1, TPlatformModeTablet = 0, TPlatformModePC = 1);

TPlatformSizes = class
public
   //main
   fmMainWidth: integer;
   fmMainHeight: integer;
   btnCtrlHeight: integer;
   btnCtrlWidth: integer;
   btnFontSize: integer;
   margin: integer;
   //check
   checkPnlSummHeight: integer;

   checkLblSummLeft: integer;
   checkLblSummTop: integer;
   checkLblSummWidth: integer;
   checkLblSummHeight: integer;

   checkEdtSummWidth: integer;
   checkEdtMargin: integer;
    //check grid
   checkGridFontSize: integer;

   checkGridCol0Width: integer;
   checkGridCol1Width: integer;
   checkGridCol2Width: integer;
   checkGridCol3Width: integer;
   checkGridCol4Width: integer;

   menuBtnWidth: integer;
   menuBtnHeight: integer;
   menuMarginTop: integer;
   menuMarginLeft: integer;
   menuPaddingTop: integer;
   menuBtnFontSize: integer;

   constructor Create(APlatformMode: TPlatformMode);

end;

var
   Sizes: TPlatformSizes;
implementation
const
   TABLET_FORM_MAIN_WIDTH = 1200;
   TABLET_FORM_MAIN_HEIGHT = 768;

   PC_FORM_MAIN_WIDTH = 1500;
   PC_FORM_MAIN_HEIGHT = 768;

   MARGIN_SHP = 10;
   CTRL_BTN_HEIGHT = 40;
   CTRL_BTN_WIDTH = 90;
   CTRL_BTN_FONT_SIZE = 12;

   CHECK_PNL_SUMM_HEIGHT = 50;

   CHECK_LBL_SUMM_LEFT = 30;
   CHECK_LBL_SUMM_TOP = 5;
   CHECK_LBL_SUMM_WIDTH = 70;
   CHECK_LBL_SUMM_HEIGHT = 40;

   CHECK_EDT_SUMM_WIDTH = 100;
   CHECK_EDT_MARGIN = 200;

   PC_CHECK_GRID_FONT_SIZE = 18;
   PC_CHECK_GRID_COL_0_WIDTH = 250;
   PC_CHECK_GRID_COL_1_WIDTH = 100;
   PC_CHECK_GRID_COL_2_WIDTH = 100;
   PC_CHECK_GRID_COL_3_WIDTH = 100;
   PC_CHECK_GRID_COL_4_WIDTH = 150;

   TABLET_CHECK_GRID_FONT_SIZE = 20;
   TABLET_CHECK_GRID_COL_0_WIDTH = 250;
   TABLET_CHECK_GRID_COL_1_WIDTH = 100;
   TABLET_CHECK_GRID_COL_2_WIDTH = 100;
   TABLET_CHECK_GRID_COL_3_WIDTH = 100;
   TABLET_CHECK_GRID_COL_4_WIDTH = 150;

   PC_MENU_BTN_WIDTH = 150;
   PC_MENU_BTN_HEIGHT = 150;
   PC_MENU_MARGIN_LEFT = 10;
   PC_MENU_MARGIN_TOP = 10;
   PC_MENU_PADDING_TOP = 150;
   PC_MENU_BTN_FONT_SIZE = 18;

   TABLET_MENU_BTN_WIDTH = 150;
   TABLET_MENU_BTN_HEIGHT = 150;
   TABLET_MENU_MARGIN_LEFT = 10;
   TABLET_MENU_MARGIN_TOP = 10;
   TABLET_MENU_PADDING_TOP = 150;
   TABLET_MENU_BTN_FONT_SIZE = 18;

{ TPlatformSizes }

constructor TPlatformSizes.Create(APlatformMode: TPlatformMode);
begin
   btnCtrlHeight := CTRL_BTN_HEIGHT;
   btnCtrlWidth := CTRL_BTN_WIDTH;
   btnFontSize := CTRL_BTN_FONT_SIZE;
   margin := MARGIN_SHP;
   checkPnlSummHeight := CHECK_PNL_SUMM_HEIGHT;
   checkLblSummLeft := CHECK_LBL_SUMM_LEFT;
   checkLblSummTop := CHECK_LBL_SUMM_TOP;
   checkLblSummWidth := CHECK_LBL_SUMM_WIDTH;
   checkLblSummHeight := CHECK_LBL_SUMM_HEIGHT;
   checkEdtSummWidth := CHECK_EDT_SUMM_WIDTH;
   checkEdtMargin := CHECK_EDT_MARGIN;
   
   if (APlatformMode = TPlatformModePC) then
   begin
      fmMainWidth := PC_FORM_MAIN_WIDTH;
      fmMainHeight := PC_FORM_MAIN_HEIGHT;
      checkGridFontSize := PC_CHECK_GRID_FONT_SIZE;
      checkGridCol0Width := PC_CHECK_GRID_COL_0_WIDTH;
      checkGridCol1Width := PC_CHECK_GRID_COL_1_WIDTH;
      checkGridCol2Width := PC_CHECK_GRID_COL_2_WIDTH;
      checkGridCol3Width := PC_CHECK_GRID_COL_3_WIDTH;
      checkGridCol4Width := PC_CHECK_GRID_COL_4_WIDTH;

      menuBtnWidth := PC_MENU_BTN_WIDTH;
      menuBtnHeight := PC_MENU_BTN_HEIGHT;
      menuMarginTop := PC_MENU_MARGIN_TOP;
      menuMarginLeft := PC_MENU_MARGIN_LEFT;
      menuPaddingTop := PC_MENU_PADDING_TOP;
      menuBtnFontSize := PC_MENU_BTN_FONT_SIZE;
   end
   else if (APlatformMode = TPlatformModeTablet) then
   begin
      fmMainWidth := TABLET_FORM_MAIN_WIDTH;
      fmMainHeight := TABLET_FORM_MAIN_HEIGHT;

      checkGridFontSize := TABLET_CHECK_GRID_FONT_SIZE;
      checkGridCol0Width := TABLET_CHECK_GRID_COL_0_WIDTH;
      checkGridCol1Width := TABLET_CHECK_GRID_COL_1_WIDTH;
      checkGridCol2Width := TABLET_CHECK_GRID_COL_2_WIDTH;
      checkGridCol3Width := TABLET_CHECK_GRID_COL_3_WIDTH;
      checkGridCol4Width := TABLET_CHECK_GRID_COL_4_WIDTH;

      menuBtnWidth := TABLET_MENU_BTN_WIDTH;
      menuBtnHeight := TABLET_MENU_BTN_HEIGHT;
      menuMarginTop := TABLET_MENU_MARGIN_TOP;
      menuMarginLeft := TABLET_MENU_MARGIN_LEFT;
      menuPaddingTop := TABLET_MENU_PADDING_TOP;
      menuBtnFontSize := TABLET_MENU_BTN_FONT_SIZE;
   end;

end;

end.
