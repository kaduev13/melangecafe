unit SaleRepository;

interface

uses Sale, Session;

type
	TSaleRepository = class
        class function GetAllForSession(ABaseName: string; ASession: TSession): TSalesArray;
    end;

implementation

{ TSaleRepository }

uses db_comps_additional, SysUtils, Discount;

class function TSaleRepository.GetAllForSession(ABaseName: string;
  ASession: TSession): TSalesArray;
var
	adc: TDBCompsAddit;
	query: string;
begin
	adc := TDBCompsAddit.Create(ABaseName);
	if not adc.Init then
	begin
		result := nil;
		raise Exception.Create('TSaleRepository.GetAllForSession Can not init adc');
		adc.Destroy;
		Exit;
	end;
	query :=
		'SELECT' +
		'	s.id as s_id, s.dt as s_dt, s.sale_type as s_st, d.id as d_id ' +
		'FROM' +
		'	sales s LEFT JOIN discounts d ON s.discount_id = d.id ' +
		'WHERE' +
		'	s.sess_id = :sess_id;';
	with adc.query do
	begin
		SQL.Text := query;
		ParamByName('sess_id').AsInteger := ASession.Id;
        try
			Open;
		except
			on E:Exception do
			begin
				result := nil;
				raise Exception.Create('TSaleRepository.GetAllForSession(); Can not execute query! Error: ' + E.Message);
				adc.Destroy;
				Exit;
			end;
		end;
		while (not eof) do
		begin
			setlength(result, length(result) + 1);
			result[high(result)] := TSale.Create(
				FieldByName('s_id').AsInteger,
				FieldByName('s_dt').AsDateTime,
				ASession,
				TDiscount.Create(FieldByName('d_id').AsInteger),
				FieldByName('s_st').AsInteger
			);
			Next;
		end;
		Close;
	end;
	adc.Destroy;
end;

end.
