table 50212 "Luxury Item Rental Order"
{
    DataCaptionFields = "No.";
    Caption = 'Luxury Item Rental Order';
    DrillDownPageID = "Luxury Item Rental Orders";
    LookupPageId = "Luxury Item Rental Orders";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    RentalSetup.Get();
                    NoSeriesMgt.TestManual(RentalSetup."Rental Item Nos");
                    Rec."No. Series" := '';
                end;
            end;
        }
        field(2; Status; Enum "Luxury Item Rental Order Status")
        {
            Caption = 'Status';
            Editable = false;
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";

            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                TestStatusOpen();

                if "Customer No." <> '' then begin
                    Customer.Get("Customer No.");
                    Customer.TestField(Blocked, 0);

                    Validate("Customer Name", Customer.Name);
                    Validate("Customer E-Mail", Customer."E-Mail");
                    Validate("Customer Phone No.", Customer."Phone No.");

                end;
            end;
        }
        field(4; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
        }
        field(5; "Customer Phone No."; Text[30])
        {
            Caption = 'Customer Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(6; "Customer E-Mail"; Text[80])
        {
            Caption = 'Customer E-Mail';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("Customer E-Mail");
            end;

        }
        field(7; "Rental Item No."; Code[20])
        {
            Caption = 'Rental Item No.';
            TableRelation = "Luxury Item"."No.";

            trigger OnValidate()
            var
                LuxuryItem: Record "Luxury Item";
            begin
                TestStatusOpen();

                if "Rental Item No." <> '' then begin
                    LuxuryItem.Get("Rental Item No.");
                    LuxuryItem.TestField(Blocked, false);

                    Validate("Luxury Item Description", LuxuryItem.Description);
                    Validate("Luxury Item Category", LuxuryItem."Luxury Item Category Code");
                    Validate("Luxury Item Rental Price", LuxuryItem."Price");
                end;

            end;

        }
        field(8; "Luxury Item Description"; text[100])
        {
            Caption = 'Luxury Item Description';
        }

        field(9; "Luxury Item Category"; text[30])
        {
            Caption = 'Luxury Item Category';
        }
        field(10; "Luxury Item Rental Price"; Decimal)
        {
            Caption = 'Luxury Item Rental Price';
            DecimalPlaces = 2;

        }
        field(15; "Rental Start"; Date)
        {
            Caption = 'Rental Start';
            trigger OnValidate()
            begin
                TestStatusOpen();
                if ("Rental Start" <> 0D) and ("Rental End" <> 0D) then //0D on tühi kuupäev, ehk määramata kp
                    "Rental Days" := "Rental End" - "Rental Start";

                Rec.Validate("Total amount");
            end;
        }
        field(16; "Rental End"; Date)
        {
            Caption = 'Rental End';
            trigger OnValidate()
            begin
                if ("Rental Start" <> 0D) and ("Rental End" <> 0D) then
                    "Rental Days" := "Rental End" - "Rental Start";

                Rec.Validate("Total amount");

            end;
        }
        field(17; "Rental Days"; Integer)
        {
            Caption = 'Rental Days';
            trigger OnValidate()
            begin
                if ("Rental Start" <> 0D) and ("Rental Days" <> 0) then
                    "Rental End" := "Rental Start" + "Rental Days";
                Rec.Validate("Total amount");


            end;

        }
        field(18; "Total amount"; Integer)
        {
            Caption = 'Total amount';

            trigger OnValidate()
            begin
                if (("Rental Start" <> 0D) and ("Rental Days" <> 0) and ("Luxury Item Rental Price" <> 0)) then
                    "Total amount" := "Rental Days" * "Luxury Item Rental Price";
            end;
        }

        field(14; "No. Series"; code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(12; "Rental Item Unit No."; code[20])
        {
            Caption = 'Rental Item Unit No.';
            TableRelation = "Luxury Item Rental Unit"."LI Unit No." where("Luxury Item No." = field("Rental Item No."));

        }
        field(19; RentalCount; Integer)
        {
            Caption = 'Rental Count';
        }


    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    var
        RentalOrder: Record "Luxury Item Rental Order";
        RentalSetup: Record "Rental Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        StatusCheckSuspended: Boolean;

    procedure PrintOrder()
    var
        _recRentalOrder: Record "Luxury Item Rental Order";
        _repRentalOrder: Report "Luxury Item Rental Order";
    begin
        _recRentalOrder.SetRange("No.", Rec."No.");

        // report.Run(report::"Rental Order", true, true,_recRentalOrder);
        _repRentalOrder.SetTableView(_recRentalOrder);   //Teeb sama asja, mida eelmine välja kommenteeritud rida
        _repRentalOrder.Run();

    end;

    procedure TestStatusOpen()
    begin
        if StatusCheckSuspended then
            exit;
        TestField(Status, Status::Open);
    end;

    procedure SuspendStatusCheck(Suspend: Boolean)
    begin
        StatusCheckSuspended := Suspend;
    end;

    procedure AssistEdit(OldOrder: Record "Luxury Item Rental Order") Result: Boolean
    begin
        RentalOrder := Rec;
        RentalSetup.Get();
        RentalSetup.TestField("Rental Order Nos.");
        if NoSeriesMgt.SelectSeries(RentalSetup."Rental Order Nos.", OldOrder."No. Series", RentalOrder."No. Series") then begin
            NoSeriesMgt.SetSeries(RentalOrder."No.");
            Rec := RentalOrder;
            UpdateRentalCount(OldOrder."Rental Item No.", -1); // Decrement rental count for old item
            UpdateRentalCount(RentalOrder."Rental Item No.", 1); // Increment rental count for new item

            Exit(true);
        end;

    end;

    local procedure InitOrderNo()
    begin
        if "No." = '' then begin
            RentalSetup.Get();
            RentalSetup.TestField("Rental Order Nos.");
            NoSeriesMgt.InitSeries(RentalSetup."Rental Order Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    trigger OnInsert()
    var
        RentalItemNo: Code[20];
    begin
        RentalItemNo := Rec."Rental Item No.";
        UpdateRentalCount(RentalItemNo, 1);
    end;



    local procedure GetTableValuePair(FieldNo: Integer) TableValuePair: Dictionary of [Integer, Code[20]]
    begin
        case true of
            FieldNo = Rec.FieldNo("Customer No."):
                TableValuePair.Add(Database::"Customer", Rec."Customer No.");
            FieldNo = Rec.FieldNo("Luxury Item Category"):
                TableValuePair.Add(Database::"Luxury Item", Rec."Luxury Item Category");

        end;
    end;

    procedure UpdateRentalItemUnit()
    var
        RentalItemUnit: Record "Luxury Item Rental Unit";
    begin
        TestStatusOpen();

        if "Rental Item Unit No." <> '' then begin
            RentalItemUnit.Get("Rental Item No.", "Rental Item Unit No.");
            RentalItemUnit.TestField(Blocked, false);

            Validate("Luxury Item Description", RentalItemUnit.Description);
        end;
    end;

    procedure UpdateRentalCount(LuxuryItemNo: Code[20]; Increment: Integer)
    var
        LuxuryItem: Record "Luxury Item";
    begin
        if LuxuryItem.Get(LuxuryItemNo) then begin
            LuxuryItem.RentalCount += Increment;
            LuxuryItem.Modify();
        end;
    end;






    // procedure UpdateRentalItem()
    // var
    //     RentalItem: Record "Luxury Item";
    // begin
    //     TestStatusOpen();

    //     if "Rental Item No." <> '' then begin
    //         RentalItem.Get("Rental Item No.");
    //         RentalItem.TestField(Blocked, false);

    //         Validate("Description", RentalItem.Description);
    //     end;
    // end;

    procedure ReleaseOrder()
    var
        MostRentedItem: Record "Luxury Item";
    begin
        Rec.TestField(Status, "Luxury Item Rental Order Status"::Open);

        Rec.TestField("No.");
        Rec.TestField("Customer No.");
        Rec.TestField("Rental Item No.");
        Rec.TestField("Rental Item Unit No.");
        Rec.TestField("Rental Start");
        Rec.TestField("Rental End");
        Rec.TestField("Rental Days");
        Rec.TestField("Total Amount");

        Rec.Status := "Luxury Item Rental Order Status"::Released;
        Rec.Modify(true);

        // Increment rental count for the rented item
        if MostRentedItem.Get(Rec."Rental Item No.") then begin
            MostRentedItem.RentalCount += 1;
            MostRentedItem.Modify();
        end;
    end;

    procedure ReOpenOrder()
    begin
        Rec.TestField(Status, "Luxury Item Rental Order Status"::Released);

        Rec.Status := "Luxury Item Rental Order Status"::Open;
        Rec.Modify(true);
    end;

    trigger OnModify()
    var
        OldRentalItemNo: Code[20];
        NewRentalItemNo: Code[20];
    begin
        OldRentalItemNo := xRec."Rental Item No.";
        NewRentalItemNo := Rec."Rental Item No.";

        if OldRentalItemNo <> NewRentalItemNo then begin
            UpdateRentalCount(OldRentalItemNo, -1); // Decrement rental count for old item
            UpdateRentalCount(NewRentalItemNo, 1); // Increment rental count for new item
        end;
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}

