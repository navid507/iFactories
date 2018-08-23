//
//  Settings.swift
//  iFactories
//
//  Created by navid einackchi on 6/14/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import Foundation
import Alamofire
class Settings {
    
    public class Language
    {
        public static let Persian = 1
        public static let English = 2
        public static let Arabic = 3
        public static let Russion = 4
        
    }
    
    
    
    public class ValidState
    {
        public static let Valid = 0
        public static let InValid = 1
        
    }
    public class Register_State {
        public static let Nothing = 0
        public static let Phone = 1
        public static let Login = 2
        public static let OK = 3
    }
    

    
    public class URLs{
       
        public static let root = "http://www.ineeeds.ir/"
        public static let base = root + "ws/"
        public static let Guild = base + "guild.php"
        
        
        public static let requests = base + "request.php"
        public static let searchShopByGuild = base + "searchShopByGuild.php"
        public static let shop = base + "search.php"
        public static let betterShop = base + "betterShop.php"
        public static let specialShop = base + "specialShop.php"
        public static let searchShopByTitle = base + "searchShopByTitle.php"
        public static let searchProductByShop = base + "searchProductByShop.php"
        public static let searchProductByTitle = base + "searchProductByTitle.php"
        public static let newProducts = base + "newProducts.php"
        public static let product = base + "product.php"
        public static let req_services = base + "requestAdd.php"
        public static let searchProductByCat = base + "searchProductByCat.php"
        public static let searchProductByBrand = base + "searchProductByBrand.php"
        public static let brands = base + "brands.php"
        public static let cats = base + "cat.php"
        public static let addProduct = base + "addProduct.php"
        public static let editProduct = base + "editProduct.php"
        public static let delProduct = base + "delProduct.php"
        
        public static let uploadImg = base + "avatar.php"
        
        public static let GDIM = base + "gdim.php"
        public static let Login = base + "login.php"
        public static let Register = base + "registerDevice.php"
        public static let Verify = base + "verifyCode.php"
        public static let SignUp = base + "profile.php"

        
    }
    
    public class OthersType {
        public static let Guild = 0;
        public static let Standards = 1;
        public static let Currency = 2;
        public static let DWay = 3;
        public static let Geo = 4;
        //        public static int Persian = 5;
    }
    
    public class GDIMName {
        public static let Guild = "Guild"
        public static let Standard = "Standard"
        public static let Currency = "Currency"
        public static let Delivery = "Delivery"
        public static let GeoLocation = "GeoLocation"
        
        
    }

    
    public class ServicesID {
        public static let MEETING = 1
        public static let NAMAYNDE = 2
        public static let MOMAYEZ = 3
        public static let MOSHAVERE = 4
        public static let BAZDID_GROUP = 5
        public static let SADERAT = 6
        public static let SARMAYEGOZARY = 7
        public static let HOZOOR = 8
        public static let TOOR = 9
        
    }
    /*
     <string-array name="services">
     <item> </item>
     <item>Meeting Request</item>
     <item>درخواست نمایندگ</item>
     <item>درخواست ممیزی</item>
     <item>درخواست مشاوره</item>
     <item>درخواست بازدید گروهی</item>
     <item>درخواست صادرات</item>
     <item>درخواست سرمایه گذاری</item>
     <item>درخواست حضور در ایران</item>
     <item>درخواست تور نمایشگاهی</item>
     </string-array>
     
     */
    public class ServicesString {
        public static let MEETING = "MEETING_Service"
        public static let NAMAYNDE = "NAMAYNDE_Service"
        public static let MOMAYEZ = "MOMAYEZ_Service"
        public static let MOSHAVERE = "MOSHAVERE_Service"
        public static let BAZDID_GROUP = "BAZDID_GROUP_Service"
        public static let SADERAT = "SADERAT_Service"
        public static let SARMAYEGOZARY = "SARMAYEGOZARY_Service"
        public static let HOZOOR = "HOZOOR_Service"
        public static let TOOR = "TOOR_Service"
        
    }
    
    public class Result {
        public static let Success = 0;
        public static let Error = 1;
        public static let NoAuth = -1;
    }

}
