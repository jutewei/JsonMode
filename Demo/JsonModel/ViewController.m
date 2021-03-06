//
//  ViewController.m
//  JsonModel
//
//  Created by Juvid on 15/9/10.
//  Copyright (c) 2015年 Juvid's. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+JsonModel.h"
//#import "JuvidModels.h"
#import "JuModel.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"jsonModel";
    _ju_textJson.font=[NSFont systemFontOfSize:16];

//    测试model
    NSData *dataResult=[_ju_textJson.string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dicResult=[NSJSONSerialization JSONObjectWithData:dataResult options:NSJSONReadingMutableContainers error:nil];
    juvidM=[JuModel juToModel:dicResult];
    NSDictionary *dic=[NSMutableDictionary dictionaryWithContentsOfFile:[self juDocumentPath]];
    if (dic) {
//        _ju_ClassName.stringValue=dic[@"class"];
        _ju_PreName.stringValue=dic[@"prefix"];
    }
//  {"result":{"desc":"查询成功","mark":"0"},"sys":{"update_time":"[\"2015-08-07 15:48:02\"]","version_addr":"XYLEPlay_08-resigned.ipa","app_type":"ios","create_name":"1","version_number":"1.0","update_name":"[\"13818287875\"]","create_time":"1","pk_id":1,"is_replace":"1"}}
    
    // Do any additional setup after loading the view.
}
-(NSString *)juDocumentPath{
    NSString *path =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [NSString stringWithFormat:@"%@/config.plist",path];
}
-(void)juSaveConfig{
    NSMutableDictionary *dicCon=[NSMutableDictionary dictionary];
    [dicCon setValue:_ju_PreName.stringValue forKey:@"prefix"];
    [dicCon writeToFile:[self juDocumentPath] atomically:YES];
}
-(void)shCreateDirectory{
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDesktopDirectory,NSUserDomainMask, YES);
    path_Desktop =[NSString stringWithFormat:@"%@/Model/",[paths objectAtIndex:0]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path_Desktop])
    {
        [fileManager createDirectoryAtPath:path_Desktop
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:NULL];
    }
}
- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    // Update the view, if already loaded.
}

- (IBAction)ju_ProductionModel:(NSButton *)sender {
    [self juSaveConfig];
    [self shCreateDirectory];
    NSError *error=nil;
    NSData *dataResult=[_ju_textJson.string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dicResult=[NSJSONSerialization JSONObjectWithData:dataResult options:NSJSONReadingMutableContainers error:&error];
    if (dicResult) {
         [self setProper:dicResult file_Name:nil];
    }
    else {
        _ju_Warm.stringValue=@"json数据异常";
        _ju_Warm.textColor=[NSColor redColor];

    }
//    NSLog(@"%@",_ju_textJson.string);
}

-(NSString *)setProper:(NSDictionary *)result file_Name:(NSString *)fileName{

    NSString *classPre=_ju_PreName.stringValue.length?_ju_PreName.stringValue:@"Ju";
    NSString *file_name;
    if (!fileName) {
        file_name=[NSString stringWithFormat:@"%@%@",classPre,_ju_ClassName.stringValue];
    }
    else{
        file_name=fileName;
    }
    
    NSString *class_name=[NSString stringWithFormat:@"%@Model",file_name];//文件名
    
    BOOL isWrite2;
    NSError *error;
    
    NSMutableString *strProperty=[NSMutableString string];//所有属性
    
    NSMutableString *strContent=[NSMutableString string];//m文件内容
    
    NSMutableString *strClass_h=[NSMutableString string];//头文件导入
    NSMutableString *strClass_m=[NSMutableString string];//m头信息
    
    [strClass_h appendFormat:@"%@",[self addInfo:class_name type:@"h"]];
    [strClass_h appendFormat:@"#import \"NSObject+JsonModel.h\"\n"];
    
    
    NSString *className;//类名

    NSString *propertyPre=[NSString stringWithFormat:@"%@_",classPre.lowercaseString];

    for (NSString *strDicKey in [result allKeys]) {
        NSString *propertyName=[NSString stringWithFormat:@"%@%@",propertyPre,strDicKey];//属性名
        NSString *setName=[NSString stringWithFormat:@"%@%@",[propertyPre capitalizedString],strDicKey];
         if([result[strDicKey] isKindOfClass:[NSArray class]]){
            [strProperty appendFormat:@"@property (nonatomic,strong) NSArray *%@;\n",propertyName];
            
             if ([result[strDicKey] count]>0&&[result[strDicKey][0] isKindOfClass:[NSDictionary class] ]) {
                 
                 id arrType=result[strDicKey][0];

                 if ([arrType isKindOfClass:[NSDictionary class]]) {
                     className=[self setProper:result[strDicKey][0] file_Name:[NSString stringWithFormat:@"%@%@",file_name,[strDicKey capitalizedString]]];
                     [strClass_h appendFormat:@"#import \"%@.h\"\n",className];
                     [strContent appendFormat:@"\n-(void)set%@:(NSArray *)%@{\n    _%@=[%@ juToModelArr:%@];\n \n}\n",setName,propertyName,propertyName,className,propertyName];
                 }
                 
             }
    
         }
        else if([result[strDicKey] isKindOfClass:[NSDictionary class]]){
            
            className=[self setProper:result[strDicKey] file_Name:[NSString stringWithFormat:@"%@%@",file_name,[strDicKey capitalizedString]]];
            [strProperty appendFormat:@"@property (nonatomic,strong) %@ *%@;\n",className,propertyName];
            [strClass_h appendFormat:@"#import \"%@.h\"\n",className];
            [strContent appendFormat:@"\n-(void)set%@:(NSDictionary *)%@{\n    _%@=[%@ juToModel:%@]; \n}\n",setName,propertyName,propertyName,className,propertyName];
            
        }
        else{
            [strProperty appendFormat:@"@property (nonatomic,strong) NSString *%@;\n",propertyName];
        }
    }
    [strProperty appendFormat:@"\n@end"];
    [strContent  appendFormat:@"\n@end"];
    
    
    [strClass_h appendFormat:@"\n@interface %@ : NSObject\n\n",class_name];
    [strClass_h appendFormat:@"%@",strProperty];
    
    
    [strClass_m appendFormat:@"%@",[self addInfo:class_name type:@"m"]];
    [strClass_m appendFormat:@"#import \"%@.h\"\n\n@implementation %@\n",class_name,class_name];
    [strClass_m appendFormat:@"%@",strContent];
    
   
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",path_Desktop,class_name]);
    isWrite2=[strClass_h  writeToFile:[NSString stringWithFormat:@"%@%@.h",path_Desktop,class_name] atomically:YES encoding:NSUTF8StringEncoding error:&error];
    isWrite2=[strClass_m writeToFile:[NSString stringWithFormat:@"%@%@.m",path_Desktop,class_name] atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if (isWrite2) {
       _ju_Warm.stringValue=@"模型生成成功,桌面Model文件夹";
        _ju_Warm.textColor=[NSColor greenColor];
        
    }else {
        _ju_Warm.stringValue=@"模型生成失败，json数据异常";
         _ju_Warm.textColor=[NSColor redColor];
       
    }
    return class_name;
}
-(NSString *)addInfo:(NSString *)className type:(NSString *)type{
    NSDateFormatter *forMatter=[[NSDateFormatter alloc]init];
    [forMatter setDateFormat:@"YYYY/M/d"];
    NSString *strYMD=[forMatter stringFromDate:[NSDate date]];
    [forMatter setDateFormat:@"YYYY"];
    NSString *strY=[forMatter stringFromDate:[NSDate date]];
   
   return [NSString stringWithFormat:@"//\n//  %@.%@\n//  JuJsonModel\n//\n//  Created by Juvid on %@.\n//  Copyright (c) %@年 Juvid's. All rights reserved.\n//\n\n",className,type,strYMD,strY];
}

@end
