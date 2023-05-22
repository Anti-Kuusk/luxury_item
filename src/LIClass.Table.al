table 50202 "Luxury Clothing Class"

{
Caption = 'Luxury Item Class';
LookupPageID = "Luxury Clothing Classes";

fields
{
    field(1; "Code"; Code[10])
    {
        Caption = 'Code';
        NotBlank = true;
    }
    field(2; "Name"; text[50])
    {
        Caption = 'Name';
    }
    field(3; "Default Renting Location Code"; Code[10])
    {
        Caption = 'Default Renting Location Code';
        TableRelation= "Item Location";
    }
  
   
}

keys
{
    key(Key1; "Code")
    {
        Clustered = true;
    }
}

trigger OnInsert()
begin
    
end;

trigger OnModify()
begin
    
end;

trigger OnDelete()
begin
    
end;

trigger OnRename()
begin
    
end;
}