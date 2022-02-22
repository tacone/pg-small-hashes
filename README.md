# Postgres Small Hashes

Sample postgres functions to reduce the size of a 16 bytes hash, without losing more entropy than necessary.

Note that this functions are not meant to be used for security purposes, they are meant to be used to reduce the size of a hash to diminuish the stored size or the displayed size.

```sql
-- sample uses to lossy compress MD5s and UUIDs
-- --------------------------------------------
--
-- beware: this compression will not preserve the ordering (that doesn't matter
--         with MD5s and *random* UUIDs of course)

-- 8 bytes hashes, 2^64 possible combinations (~1.8 billions of billions)

select encode(small_hash (md5('hello world!')::bytea), 'base64');
-- result: XgAFB1ZdC1U=

select encode(small_hash(uuid_generate_v4()::text::bytea), 'base64');
-- result: HAkGUAgdBAU=

-- 4 bytes hashes, 2^32 possible combinations (warning! only ~4.2 billions)

select encode(tiny_hash(md5('hello world!')::bytea), 'base64');
-- result: CF0OUg==

select encode(tiny_hash(uuid_generate_v4()::text::bytea), 'base64');
-- result: FhsPUg==
```
