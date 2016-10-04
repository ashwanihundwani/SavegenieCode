//
//  SVConstants.swift
//  IGTCarpool
//
//  Created by Ashwani on 07/03/16.
//  Copyright © 2016 Gaurav. All rights reserved.
//

import UIKit

internal class SVConstants: NSObject {
    
    // Server URL
    
    //DEV server
    static internal let SERVER_URL = "http://test.savegenie.mu/"
    
    //LIVE server
    //static internal let SERVER_URL = "http://savegenie.mu/"
    
    
    static internal let TERMS_URL = "http://savegenie.mu//pages/termsOfUse"
    static internal let PRIVACY_URL = "http://savegenie.mu//pages/privacyPolicy"
    
    static internal let IMAGE_BASE_URL = SERVER_URL + "app/webroot/img/allproduct_images/"
    static internal let BANNER_BASE_URL = SERVER_URL + "app/webroot/img/entry_pics/"
    static internal let CATEGORY_BASE_URL = SERVER_URL + "img/shop_images/"
    static internal let STORE_IMAGE_BASE_URL = SERVER_URL + "img/shop_images/"
    static internal let MASTER_CATEGORY_BASE_URL = SERVER_URL + "img/master_cat_images/"
    static internal let PRODUCT_LARGE_IMAGE_URL = SERVER_URL + "img/allproduct_large_image/"
    
    static internal let LOGIN_URL:String = SERVER_URL + "usermgmt/users/androidLogin.json"
    
    static internal let REGISTER_URL:String = SERVER_URL + "usermgmt/users/androidRegister.json"
    
    static internal let FAV_PRODUCTS_URL:String = SERVER_URL + "Pages/androidGetFavProducts.json"
    
    static internal let SELECT_CART_URL:String = SERVER_URL + "SgenieCarts/androidCreateOrSelectList.json"
    
    static internal let UPDATE_CART_URL:String = SERVER_URL + "SgenieCarts/androidAddToList.json"
    
    static internal let ORDER_DETAIL_URL:String = SERVER_URL + "Orders/androidOrderDetails.json"
    
    //static internal let ORDER_DETAIL_URL:String = "http://localhost/Savegenie/OrderDetail.json"
    
    //static internal let FAV_PRODUCTS_URL:String = "http://localhost/Savegenie/favProducts.json"
    
    static internal let AREAS_URL:String = SERVER_URL + "Areas/androidAllServedAreas.xml"
    
    static internal let MY_PROFILE_URL:String = SERVER_URL + "Pages/androidMyprofile.xml"
    
    
    static internal let CART_URL:String = SERVER_URL + "SgenieCarts/androidListItems.json"
    
    static internal let DELETE_CART_ITEM_URL:String = SERVER_URL +  "SgenieCarts/andDeleteProductFromCart.json"
    
    static internal let CART_BADGE_COUNT:String = SERVER_URL + "Pages/androidCurrentList.json"
    
    static internal let CART_INFO:String = SERVER_URL + "Pages/androidAllStoresByDefault.xml"
    
    static internal let USER_ADDRESSES = SERVER_URL + "Orders/androidShippingAddress.json"
    
    static internal let SELECT_ADDRESS = SERVER_URL + "Orders/androidChooseAddress.json"
    
    static internal let APPLY_COUPON = SERVER_URL + "Orders/androidApplySgenieCoupon.json"
    
    static internal let SELECT_DELIVERY_SLOT = SERVER_URL + "Orders/androidGetStoreSlotDetails.json"
    
    static internal let THREE_HOURS_DELIVERY = SERVER_URL + "StoreSlots/threeHoursDelivery.json"
    
    static internal let REFERRAL_DETAILS = SERVER_URL + "Referrals/referralDetailsForUser.json"
    
    static internal let MY_ORDER_URL:String = SERVER_URL + "Pages/androidMyOrder.json"
    
    static internal let ORDER_INFO_BY_ID:String = SERVER_URL + "Orders/androidOrderInfoById.json"
    
    static internal let MY_LIST:String = SERVER_URL + "SgenieCarts/androidUserExistList.json"
    
    static internal let CHOOSE_LIST:String = SERVER_URL + "SgenieCarts/androidUserChooseList.json"
    
    static internal let ENTER_SHIPPING_ADDRESS:String = SERVER_URL + "Orders/androidEnterShippingAddress.json"
    
    static internal let SAVE_ADDRESS:String = SERVER_URL + "Orders/androidSaveShippingAddress.xml"
    
    
    static internal let GET_DEALS:String = SERVER_URL + "Pages/androidGetDeals.json"
    
    static internal let GET_BANNERS:String = SERVER_URL + "Pages/entryAppPics.json"
    
    static internal let SHOP_CATEGORIES:String = SERVER_URL + "Shopcategories/androidShopCategory.json"
    
    static internal let GET_STORES:String = SERVER_URL + "Pages/androidAvilShopCatStores.json"
    
    static internal let MASTER_CATEGORY_STORE:String = SERVER_URL + "Pages/androidMastCatByStore.json"
    
    static internal let CHANGE_AREA:String = SERVER_URL + "Pages/androidChangeArea.json"
    
    static internal let COMMON_SLOT:String = SERVER_URL + "Pages/androidStoreCommonSlot.json"
    
    static internal let PROMOS:String = SERVER_URL + "Pages/androidPromoJsonByStore.json"
    
    static internal let SPONSORED_PRODUCTS:String = SERVER_URL + "Stores/getSupplierAdSponsorProductData.json"
    
    static internal let PRODUCT_DETAIL_URL:String = SERVER_URL + "Stores/androidProductDescription.json"
    
    
    static internal let DATA_ZIP_URL:String = "http://data.savegenie.mu/mobilejson/savegenie-dev-mu.zip"
    

    //static internal let DATA_ZIP_URL:String = "http://data.savegenie.mu/mobilejson/savegenie-mu.zip"
    

    //static internal let DATA_ZIP_URL:String = "http://localhost/savegenie-mu.zip"
    
    static internal let INTERNET_ERROR_MESSAGE = "Internet connection appears to be offline."

    static internal let CONNECTION_ERROR_MESSAGE = "Error in communication with the server"
    
    static internal let MAPPER_SERIALIZATION_ERROR_CODE = -6004
    
    static internal let LOGIN_ERROR_MESSAGE = "Invalid Username or Password"
    
    static internal let APP_NAME = "Savegenie"
    
    static internal let EMAIL_BLANK_VALIDATION_MESSAGE = "Email cannot be blank"
    
    static internal let PASSWORD_BLANK_VALIDATION_MESSAGE = "Password cannot be blank"
    
    static internal let EMAIL_VALIDATION_MESSAGE = "Please enter a valid email address"
    
    static internal let INCORRECT_USERNAME_OR_PASSWORD = "Incorrect Username or Password."
    
    static internal let PROFILE_CREATION_SUCCESS_MESSAGE = "Your profile is created successfully"
    
    static internal let APP_THEME_COLOR_RED = "FF3359"
    
    static internal let LOADER_COLOR_HEX = "35A0BE"
    
    static internal let DEFAULT_IOS_BLUE_COLOR_HEX = "007AFF"
    
    static internal let API_LOADER_TAG = 67890
    
    
    static internal let LOGOUT_MESSAGE_ALERT = "Do you really want to logout?"
    static internal let LOGOUT_CANCEL_BUTTON_TEXT = "Cancel"
    static internal let LOGOUT_BUTTON_TEXT = "Logout"
    
    
    static internal let USER_DETAIL_ARCHIVE_KEY = "user_details"
    static internal let DATA_AVAILABLE_KEY = "valid_data_available"
    static internal let DATA_TIMESTAMP_KEY = "data_timestamp"
    static internal let BADGE_KEY = "badge_key"
    static internal let CART_INFO_KEY = "cart_info_key"
    
    static internal let PRODUCT_DB_ENTITY = "SVProduct"
    static internal let CATEGORY_DB_ENTITY = "SVProductCategory"
    

    static internal let CART_UPDATED_NOTIFICATION = "cart_updated_notification"
    
    static internal let BANNER_HEIGHT_MULTIPLIER:CGFloat = 0.45
    
}
