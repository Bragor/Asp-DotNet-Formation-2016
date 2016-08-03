<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="jquery1.aspx.cs" Inherits="JqueryTest.jquery1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    
    <!-- Style CSS pour JQuery Validate : c'est le style de base, à vous le customiser-->
    <link href="jquery_validate/css/jquery_validate.css" rel="stylesheet" />
    
    <!-- JQuery Validate Documentation : http://jqueryvalidation.org/ -->
    <!-- JQuery Validate Lastest Realeses : https://github.com/jzaefferer/jquery-validation/releases -->
    <!-- JQuery Validate ASP.Net tutorial : http://www.c-sharpcorner.com/UploadFile/ee01e6/jquery-validation-with-Asp-Net-web-form/ -->

    <!-- on ajouter les fichiers Javascript pour les fonctions du JQuery Validate -->
    
    <!--include jQuery -->  
    <script src="jquery_validate/jquery-1.12.4.js"></script>
    
    <!-- Scripts JQuery Validate -->
    <script src="jquery_validate/jquery.validate-1.15.1.js"></script>
    
    <!-- Scripts JQuery Validate : methodes additionnelles -->
    <script src="jquery_validate/additional-methods.js"></script>
    
    <!-- Scripts JQuery Validate : localisation des messages -->
    <script src="jquery_validate/localization/messages_fr.js"></script>
    
    <!-- JQuery Validate Script -->
        <script type ="text/javascript" >                
            //Document sur lequel on va valider les données du formulaires
            $(document).ready(function () {
                //---------------------------------------------------------------------------------------------------
                //ajout de methodes personalisées (customs methods)
                //création d'un contrôle personalisé type regular expression
                //---------------------------------------------------------------------------------------------------

                //---------------------------------------------------------------------------------------------------
                //                                      ATTENTION n°1
                //---------------------------------------------------------------------------------------------------
                //Ici, ce ne sont que des méthodes dites "OneShot", donc si elles doivent être utilisées de manière récurente,
                //le mieux est des les placer dans le fichier "additional-methods.js" en respectant l'écriture.
                //De plus de pas oublier de mettre les noms ajoutés dans le fichier de localisation "messages_fr.js".
                //
                //---------------------------------------------------------------------------------------------------
                //                                      ATTENTION n°2
                //---------------------------------------------------------------------------------------------------
                //Attention : si vous avez besoin d'utiliser différentes expressions régulières, ajoutez une méthode n'ayant pas le même nom que les autres
                //Cependant si vous avez plusieurs objet du formulaire qui doivent être contôler par la même expression régulière pour le même formulaire,
                //inutile de dupliquer la même méthode, il suffit de la réutilisée dans la section "rules"
                //$.validator.addMethod("match", function(value, element) //on ajoute la method "match"
                //{
                //    return this.optional(element) || /^[a-zA-Z]+[\s-a-zA-Z0-9]+$/i.test(value); //l'expression régulière à changer se trouve entre le "/" et "/i"
                //}, "Alpha en premier suivi de caractère autorisés : alpha, numérique, espase ou -."); //message en cas d'échec sur l'expression régulière
        
                ////custom rule to check regular expression   
                $.validator.addMethod("matchemail", function(value, element) //on ajoute la method "matchEmail"
                {  
                    return this.optional(element) || /^[a-zA-Z0-9._-]+@[a-zA-Z0-9-]+\.[a-zA-Z.]{2,5}$/i.test(value);  //l'expression régulière à changer se trouve entre le "/" et "/i"
                }, "Merci d'entre une adresse mail valide."); //message en cas d'échec sur l'expression régulière

                $("#form1").validate({
                    rules: {  
                        //section rules : determine the rules for each control
                        //---------------------------------------------------------------------------------------------------
                        //des règles de contôles sont déjà incluses dans JQuery Validate
                        //les methodes principales :
                        //required: true => obligatoire
                        //email: true => champs email
                        //url: true => champs type url/lien
                        //digits: true => champs type nombre uniquement
                        //date: true => champs date
                        //range: [10, 15] => accepte uniquement les nombres compris entre 10 et 15
                        //minlength: 10 => longueur minimum
                        //maxlength: 20 => logueur maximum
                        //rangelength: [10, 20] => longueur comprise entre 10 et 20
                        //equalto:#<%-- <%=NomDuTextBox.UniqueId %> --%>
                        //---------------------------------------------------------------------------------------------------
                        //                                                  ATTENTION
                        //---------------------------------------------------------------------------------------------------
                        //This section we need to place our custom rule   
                        //for the control.  
                        <%=Text_Box.UniqueID %>:{  
                            required:true,
                            email:true
                        },   
                        //Rules pour RadioButton
                        <%=Radio_Button.UniqueID %>:{
                            required:true //required : champs obligatoire.
                        },
                        <%=Check_Box.UniqueID %>:{
                                    required:true //required : champs obligatoire.
                                },
                        //Rules pour FileUpload
                        <%=File_Upload.UniqueID %>:{
                                    required:true, //required : champs obligatoire.
                                    fileSize: [true, 1, "Gb"] //methode personalisée : vérifié que le fichier uploader n'excede pas 1Gb
                                },
                        <%=Drop_DownList.UniqueID %>:{
                                    CheckDropDownList:true //choix dans la liste déroulante obligatoire
                                },
                        <%=RadioButton_List.UniqueID %>:{
                                    required:true //selection du radio bouton obligatoire
                                },
                        <%=List_Box.UniqueID %>:{
                                    required:true //required : champs obligatoire.
                                },
                        <%=CheckBox_List.UniqueID %>:{
                                    required:true, //required : champs obligatoire.
                                    range:[1,2] // 2
                                },
                    },  
                    messages: {
                        //les messages ici overdrive les messages par défaut, qu'ils soient localisés ou pas
                        //même syntax que dans la section rules.
                    }, 
                    //Error placement for radio buttons  
                    errorPlacement: function(error, element)   
                    {  
                        if ( element.is(":radio") | element.is(":checkbox") )   
                        {  
                            error.appendTo( element.parents('.radioclass') );  
                        }    
                        else  
                        { // This is the default behavior   
                            error.insertAfter(element );  
                        }
                    },
                });  
            });         
    </script>
</head>

<body>
    <form id="form1" runat="server">
    <div>
    <table class="auto-style1">
            <tr>
                <td><asp:Label ID="Label1" runat="server" Text="TextBox"></asp:Label></td><td>
                    <!-- l'option ClientIDMode="Static" est obligatoire -->
                    <!-- l'option CausesValidation="True" est obligatoire -->
                    <asp:TextBox ID="Text_Box" runat="server" ClientIDMode="Static" CausesValidation="True"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td><asp:Label ID="Label2" runat="server" Text="DropDownList"></asp:Label></td>
                <td><asp:DropDownList ID="Drop_DownList" runat="server" ClientIDMode="Static" CausesValidation="True">
                    <asp:ListItem Text="Choisir:" Value="0"></asp:ListItem>
                    <asp:ListItem Text="toto" Value="1"></asp:ListItem>
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label3" runat="server" Text="FileUpload"></asp:Label></td>
                <td><asp:FileUpload ID="File_Upload" runat="server" ClientIDMode="Static" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label5" runat="server" Text="ListBox"></asp:Label></td>
                <td><asp:ListBox ID="List_Box" runat="server" ClientIDMode="Static" CausesValidation="True">
                    <asp:ListItem Text="text1" Value="1"></asp:ListItem>
                    <asp:ListItem Text="text2" Value="2"></asp:ListItem>
                    <asp:ListItem Text="text2" Value="2"></asp:ListItem>
                    <asp:ListItem Text="text2" Value="2"></asp:ListItem>
                    </asp:ListBox></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label6" runat="server" Text="CheckBox"></asp:Label></td>
                <td><asp:CheckBox ID="Check_Box" runat="server" ClientIDMode="Static" CausesValidation="True" text="Check Box à cocher" CssClass="radioclass" /></td>
            </tr>
            <tr>
                <td><asp:Label ID="Label7" runat="server" Text="CheckBoxList (not working atm)"></asp:Label></td>
                <td><asp:CheckBoxList ID="CheckBox_List" runat="server" ClientIDMode="Static" CausesValidation="True">
                    <asp:ListItem Text="Test 1" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Test 2" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Test 3" Value="3"></asp:ListItem>
                    </asp:CheckBoxList>
                </td>
            </tr>
            <tr>
                <td><asp:Label ID="Label8" runat="server" Text="RadioButton"></asp:Label></td>
                <td><asp:RadioButton ID="Radio_Button" runat="server" ClientIDMode="Static" CausesValidation="True" CssClass="radioclass" Text="Radio Button à Cocher" Checked="false"/>
                    
                </td>
            </tr>
            <tr>
                <td><asp:Label ID="Label9" runat="server" Text="RadioButtonList"></asp:Label></td>
                <td><asp:RadioButtonList ID="RadioButton_List" runat="server" ClientIDMode="Static" CausesValidation="True" CssClass="radioclass">
                    <asp:ListItem Text="Test 1" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Test 2" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Test 3" Value="3"></asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td><asp:Button ID="Button_Submit" runat="server" Text="Envoyer/Enregistrer/Ok" OnClick="Button_Submit_Click" /></td>
                <td><asp:Button ID="Button_Cancel" runat="server" Text="Cancel/Reset" /></td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
