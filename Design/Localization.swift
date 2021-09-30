//
//  Localization.swift
//  Flowers
//
//  Created by Алексей on 29.12.2020.
//

import Foundation

struct Localization {
    
    struct App {
        public static var name : String = "app.name".localized()
    }
    
    struct Error {
        public static var support : String = "error.support".localized()
    }
    
    struct Splash {
        public static var name : String = App.name
    }
    

    struct Auth {
        public static var name : String = "auth.name".localized()
        public static var textEmail : String = "auth.email.text".localized()
        public static var textCode : String = "auth.code.text".localized()
        public static var timeCode : String = "auth.code.time".localized()
        public static var text : String = "auth.text".localized()
        public static var email : String = "auth.email".localized()
        public static var code : String = "auth.code".localized()
        
        
        public static var sendEmail : String = "auth.email.send".localized()
        public static var sendCode : String = "auth.code.send".localized()
        public static var prevCode : String = "auth.code.prev".localized()

        
        struct Error {
            public static var noCodeAuth: String = "auth.error.code.no_auth".localized()
            public static var noEmailAuth: String = "auth.error.email.no_auth".localized()
            
            public static var noAuth : String = "auth.error.no_auth".localized()
            public static var noEmptyFieldEmail : String = "auth.error.email.empty_field".localized()
            public static var noEmptyFieldCode : String = "auth.error.code.empty_field".localized()
        }
   
        
    }
    
    struct Network {
        public static var errorJson : String = "netrwork.error.json".localized()
    }
    
    struct Token {
        public static var error : String = "token.error".localized()
    }
  
    struct Profil {
        public static var title : String = "profil.title".localized()
        public static var titleTab : String = "profil.tab".localized()
        public static var emailParam : String = "profil.param.email".localized()
        public static var emailNameParam : String = "profil.param.email.name".localized()
        public static var dateParam : String = "profil.param.date".localized()
        public static var exit : String = "profil.exit".localized()
    }
    
    struct Feedback {
        public static var title : String = "feedback.title".localized()
        public static var titleTab : String = "feedback.tab".localized()
        public static var fioParam : String = "feedback.param.fio".localized()
        public static var emailParam : String = "feedback.param.email".localized()
        public static var textParam : String = "feedback.param.text".localized()
        public static var titleSub : String = "feedback.titleSub".localized()
        public static var sendParam : String = "feedback.param.send".localized()
        public static var text : String = "feedback.text".localized()
        public static var success : String = "feedback.success".localized()
        public static var error : String = "feedback.error".localized()
        public static var fioParamNo : String = "feedback.param.fioNo".localized()
        public static var emailParamNo : String = "feedback.param.emailNo".localized()
        public static var textParamNo : String = "feedback.param.textNo".localized()
    }
   

    struct ListVote {
        public static var title : String = "vote.list.title".localized()
        public static var titleTab : String = "vote.list.tab".localized()
        public static var searchPlaceholder : String = "vote.list.search.placeholder".localized()        
        public static var countParam : String = "vote.list.param.count".localized()
        public static var dateParam : String = "vote.list.param.date".localized()
        public static var topicFilter : String = "vote.list.name".localized()
        
    }
    
    struct FilterListVote {
        public static var title : String = "vote.filter.title".localized()
        public static var topicParam : String = "vote.filter.param.topic".localized()
    }

    
    struct DetailVote {
        public static var title : String = "vote.detail.title".localized()
        public static var errorNoVote : String = "vote.detail.error.noVote".localized()
        public static var send : String =  "vote.detail.send".localized()
        public static var noAuth : String =  "vote.detail.error.poll.auth".localized()
        public static var errorNoVaraiant : String = "vote.detail.error.noVaraiant".localized()
    }
    
    
   
    struct Alert {
        
        public static var okButton : String = "alert.ok.button".localized()
        public static var canselButton : String = "alert.cansel.button".localized()
        public static var tite : String = "alert.title".localized()
        
        struct Error {
            public static var tite : String = "alert.error.title".localized()
            public static var message : String = "alert.error.message".localized()
          
        }
        struct Profil {
            public static var okButton : String = "profil.alert.ok.button".localized()
            public static var title : String = "profil.alert.title".localized()
            public static var message : String = "profil.alert.message".localized()
        }
        
        
    }
    
}


