unit Discount;

interface
type
	TDiscount = class
		id: integer;
		amount: integer;
		used: integer;
		seria: integer;
		number: integer;
	public
		constructor Create(AId, AAmount, AUsed, ASeria, ANumber: integer); overload;
		constructor Create(AAmount, AUsed, ASeria, ANumber: integer); overload;
		constructor Create(); overload;
		constructor Create(AId: integer); overload;
	end;

	TDiscountArray = array of TDiscount;

	TDiscountSeriaBlock = record
		numberStarts: integer;
		numberEnds: integer;
		seria: integer;
		amount: integer;
		used: integer;
		notUsed: integer;
	end;

	TDiscountSeriaBlockArray = array of TDiscountSeriaBlock;

	function DiscountSeriaBlockToString(ABlock: TDiscountSeriaBlock): string;

implementation

uses SysUtils;

function DiscountSeriaBlockToString(ABlock: TDiscountSeriaBlock): string;
begin
	result := 'C���� ' + IntToStr(ABlock.seria) +
		', �� ������������: ' + IntToStr(ABlock.notUsed) +
		', ������������: ' + IntToStr(ABlock.used);
end;

{ TDiscount }

constructor TDiscount.Create(AId, AAmount, AUsed, ASeria, ANumber: integer);
begin
	Id := AId;
	Amount := AAmount;
	Used := AUsed;
	Seria := ASeria;
	Number := ANumber;
end;

constructor TDiscount.Create(AAmount, AUsed, ASeria, ANumber: integer);
begin
	Amount := AAmount;
	Used := AUsed;
	Seria := ASeria;
	Number := ANumber;
end;

constructor TDiscount.Create;
begin
	id := -1;
end;

constructor TDiscount.Create(AId: integer);
begin
	Id := AId;
end;

end.
