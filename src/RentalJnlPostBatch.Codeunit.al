codeunit 50202 "Rental Jnl.-Post Batch"
{
    TableNo = "Rental Journal Line";

    var
        RentalJnlLine: Record "Rental Journal Line";
        RentalJnlLine3: Record "Rental Journal Line";
        Window: Dialog;
        StartLineNo: Integer;
        LineCount: Integer;
        NoOfRecords: Integer;
        RentalJnlCheckLine: Codeunit "Rental Jnl.-Check Line";
        RentalJnlPostLine: Codeunit "Rental Jnl.-Check Line";
        Text001: Label 'Journal Batch Line    #1##########\\';
        Text002: Label 'Checking lines        #2######\';
        // Text003: Label 'Posting lines         #3###### @4@@@@@@@@@@@@@\';
        // Text004: Label 'Updating lines        #5###### @6@@@@@@@@@@@@@';
        Text005: Label 'Posting lines         #3###### @4@@@@@@@@@@@@@';


    trigger OnRun()
    begin
        RentalJnlLine.Copy(Rec);
        Code();
        Rec := RentalJnlLine;
    end;

    local procedure "Code"()
    begin
        Window.Open(
                  Text001 +
                  Text002 +
                  Text005);
        Window.Update(1, RentalJnlLine."Line No.");

        // Check lines
        LineCount := 0;
        StartLineNo := RentalJnlLine."Line No.";
        repeat
            LineCount := LineCount + 1;
            Window.Update(2, LineCount);
            RentalJnlCheckLine.RunCheck(RentalJnlLine);
            if RentalJnlLine.Next() = 0 then
                RentalJnlLine.FindFirst();
        until RentalJnlLine."Line No." = StartLineNo;
        NoOfRecords := LineCount;

        // Post lines
        LineCount := 0;
        RentalJnlLine.FindSet();
        repeat
            LineCount := LineCount + 1;
            Window.Update(3, LineCount);
            Window.Update(4, Round(LineCount / NoOfRecords * 10000, 1));
            if not RentalJnlLine.EmptyLine()
            then
                RentalJnlLine.TestField("Document No.");

            RentalJnlPostLine.RunCheck(RentalJnlLine);
        until RentalJnlLine.Next() = 0;


        // Update/delete lines
        RentalJnlLine3.Copy(RentalJnlLine);
        RentalJnlLine3.DeleteAll();

        Commit();

    end;
}