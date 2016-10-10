//
//  CSJSTableView.m
//  CSJSView
//
//  Created by 沈强 on 16/8/19.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import "CSJSTableView.h"
#import "CSJSViewEngine.h"
#import <objc/runtime.h>


@interface CSJSTableView (){
  NSString *jsValueAdress;
}

@end

@implementation CSJSTableView

+ (instancetype)jsTableViewWithFrame:(CGRect)frame andStyle:(UITableViewStyle)style {
  CSJSTableView * tableview= [[self alloc]initWithFrame:frame style:style];
  
  tableview.tableFooterView = [UIView new];
  tableview.delegate = tableview;
  tableview.dataSource = tableview;
  [tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CSJSTableViewCell"];
  return tableview;
}

- (JSValue *)jsDelegate {
  return [CSJSViewEngine jsValueWith:jsValueAdress];

}

- (void)setJsDelegate:(JSValue *)jsDelegate {
  if ([[jsDelegate objectForKeyedSubscript:@"nativeBridgeIdentifier"] isUndefined]) {
    [jsDelegate setObject:[[NSUUID UUID] UUIDString] forKeyedSubscript:@"nativeBridgeIdentifier"];
  }
  [CSJSViewEngine retainJSValue:jsDelegate];
  jsValueAdress = [[jsDelegate objectForKeyedSubscript:@"nativeBridgeIdentifier"] toString];
}

#pragma mark - UITableviewDataSource

#pragma mark - required

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (![[self.jsDelegate objectForKeyedSubscript:@"numberOfRowsInSection"] isUndefined]) {
    return [[[self.jsDelegate invokeMethod:@"numberOfRowsInSection" withArguments:@[tableView, @(section)] ] toNumber] integerValue];
  }
  return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSJSTableViewCell" forIndexPath:indexPath];
  UIView *tagContentView = [cell.contentView viewWithTag:10000];
  if (tagContentView) {
    [tagContentView removeFromSuperview];
  }
  if (![[self.jsDelegate objectForKeyedSubscript:@"cellForRowAtIndexPath"] isUndefined]) {
    UIView *contentView =  [[self.jsDelegate invokeMethod:@"cellForRowAtIndexPath" withArguments:@[tableView, indexPath]] toObject];
    contentView.tag = 10000;
    [cell.contentView addSubview:contentView];
  }
  return cell;
}


#pragma mark - option

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  if (![[self.jsDelegate objectForKeyedSubscript:@"numberOfSectionsInTableView"] isUndefined]) {
    return [[[self.jsDelegate invokeMethod:@"numberOfSectionsInTableView" withArguments:@[tableView]] toNumber] integerValue];
  }
  return 1;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  if (![[self.jsDelegate objectForKeyedSubscript:@"titleForHeaderInSection"] isUndefined]) {
    return [[self.jsDelegate invokeMethod:@"titleForHeaderInSection" withArguments:@[tableView, @(section)]] toString];
  }
  return nil;
  
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
  if (![[self.jsDelegate objectForKeyedSubscript:@"titleForFooterInSection"] isUndefined]) {
    return [[self.jsDelegate invokeMethod:@"titleForFooterInSection" withArguments:@[tableView, @(section)]] toString];
  }
  return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  if (![[self.jsDelegate objectForKeyedSubscript:@"canEditRowAtIndexPath"] isUndefined]) {
    return [[self.jsDelegate invokeMethod:@"canEditRowAtIndexPath" withArguments:@[tableView, indexPath]] toBool];
  }
  return NO;
}



- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
  if (![[self.jsDelegate objectForKeyedSubscript:@"canMoveRowAtIndexPath"] isUndefined]) {
    return [[self.jsDelegate invokeMethod:@"canMoveRowAtIndexPath" withArguments:@[tableView, indexPath]] toBool];
  }
  return NO;
}



- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView  {
  if (![[self.jsDelegate objectForKeyedSubscript:@"sectionIndexTitlesForTableView"] isUndefined]) {
    return [[self.jsDelegate invokeMethod:@"sectionIndexTitlesForTableView" withArguments:@[tableView]] toArray];
  }
  return nil;
  
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index  {
  if (![[self.jsDelegate objectForKeyedSubscript:@"sectionForSectionIndexTitleAtIndex"] isUndefined]) {
    return [[[self.jsDelegate invokeMethod:@"sectionForSectionIndexTitleAtIndex" withArguments:@[tableView,title,@(index)]] toNumber] integerValue];
  }
  return 0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (![[self.jsDelegate objectForKeyedSubscript:@"commitEditingStyleForRowAtIndexPath"] isUndefined]) {
     [self.jsDelegate invokeMethod:@"commitEditingStyleForRowAtIndexPath" withArguments:@[tableView,@(editingStyle), indexPath]];
  }
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
  if (![[self.jsDelegate objectForKeyedSubscript:@"moveRowAtIndexPathToIndexPath"] isUndefined]) {
    [self.jsDelegate invokeMethod:@"moveRowAtIndexPathToIndexPath" withArguments:@[tableView,sourceIndexPath, destinationIndexPath]];
  }
}

#pragma mark - UITabelviewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (![[self.jsDelegate objectForKeyedSubscript:@"didSelectRowAtIndexPath"] isUndefined]) {
    [self.jsDelegate invokeMethod:@"didSelectRowAtIndexPath" withArguments:@[tableView, indexPath]];
  }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (![[self.jsDelegate objectForKeyedSubscript:@"didDeselectRowAtIndexPath"] isUndefined]) {
    [self.jsDelegate invokeMethod:@"didDeselectRowAtIndexPath" withArguments:@[tableView, indexPath]];
  }
}

- (void)dealloc {
  [CSJSViewEngine releaseJSValueWith:jsValueAdress];
  NSLog(@"UITableView RELEASE %@", self);
}

@end
