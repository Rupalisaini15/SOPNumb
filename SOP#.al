// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50132 CustomerListExt extends "Sales Order List"
{

    layout
    {
        addafter("No.")
        {
            field(ItemPart; SmartField(Rec))
            {
                Caption = 'Part Number';
                ApplicationArea = All;

            }
        }
    }
    procedure SmartField(Header: Record "Sales Header"): Text

    var
        SL: Record "Sales Line";
        ItemPart: Text;
    begin
        //Message('App published: Hello world');
        SL.SETRANGE("Document Type", Header."Document Type");
        SL.SETRANGE("Document No.", Header."No.");
        SL.SETRANGE("Type", SL.Type::Item);
        IF SL.FindSet() Then
            repeat
                if
                   ItemPart <> '' then
                    ItemPart += ' | ' + SL."No."

                else
                    ItemPart := SL."No."
               until
               SL.Next() = 0;


        EXIT(ItemPart);

        //exit('Smarter' + PurchaseHeader."No.");
    end;
}