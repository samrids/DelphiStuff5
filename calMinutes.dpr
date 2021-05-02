program calMinutes;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.DateUtils,
  System.SysUtils,
  System.Classes;

procedure Split(Delimiter: Char; Str: string; ListOfStrings: TStrings);
begin
  ListOfStrings.Clear;
  ListOfStrings.Delimiter := Delimiter;
  ListOfStrings.StrictDelimiter := True;
  ListOfStrings.DelimitedText := Str;
end;

var
  L, Llocal: TStrings;
  i, j: word;
  res, rcal: Integer;
  ch: Char;

const
  d = 'วัน';
  h = 'ชม.';
  m = 'นาที';

begin
  try
    L := TStringList.create;
    Llocal := TStringList.Create;
    L.LoadFromFile('c:\temp\time.txt', TEncoding.UTF8);
    try
      for i := 0 to pred(L.Count) do
      begin
        res := 0;
        rcal := 0;
        Split(' ', L.Strings[i], Llocal);
        write(format('%d%s%s', [i, chr(9), L.Strings[i]]));
        for j := 0 to pred(Llocal.Count) do
        begin
          for ch in Llocal.Strings[j] do
          begin
            if ord(ch) in [48 .. 57] then
              rcal := strtoint(Llocal.Strings[j])
            else
            begin
              if (Trim(Llocal.Strings[j]) = d) then
                res := res + rcal * MinsPerDay
              else if (Trim(Llocal.Strings[j]) = h) then
                res := res + rcal * MinsPerHour
              else if (Trim(Llocal.Strings[j]) = m) then
                res := res + rcal;
            end;
            break;
          end;
        end;
        Write(format('%s%s%s%s%s = %d minutes', [chr(9), chr(9), chr(9), chr(9),
          chr(9), res]));
        writeln;
      end;
    except
      on E: Exception do
        writeln(E.ClassName, ': ', E.Message);
    end;
  finally
    L.free;
    Llocal.free;
  end;
  Readln;
  Write('Press any key to exit');

end.
