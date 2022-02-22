-- functions to make hashes smaller
-- derived from: https://stackoverflow.com/a/36061430/358813
-----------------------------------------------------------------

-- Converts a 16 byte hash to a 8 byte hash 
create or replace function small_hash(hash16 bytea) returns bytea
as $$
declare
  result bytea;
  idx int;
begin
  result := decode('0000000000000000', 'hex'); -- prepopulate with some 8-byte data
  for idx in 0..7 loop
    result := set_byte(result, idx,
                                   get_byte(hash16, idx) #                                 
                                   get_byte(hash16, idx + 8));
  end loop;
  return result;
end;
$$ language plpgsql immutable parallel safe;

--Converts a 16 byte hash to a 4 byte hash
create or replace function tiny_hash(hash16 bytea) returns bytea
as $$
declare
  result bytea;
  idx int;
begin
  result := decode('00000000', 'hex'); -- prepopulate with some 4-byte data
  for idx in 0..3 loop
  result := set_byte(result, idx,
                                  get_byte(hash16, idx) #
                                  get_byte(hash16, idx + 4) #
                                  get_byte(hash16, idx + 8) #
                                  get_byte(hash16, idx + 12));                                  
  end loop;
  return result;
end;
$$ language plpgsql immutable parallel safe;
