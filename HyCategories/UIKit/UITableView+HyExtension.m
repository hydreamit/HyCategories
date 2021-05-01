//
//  UITableView+HyExtension.m
//  HyCategories
//  https://github.com/hydreamit/HyCategories
//
//  Created by Hy on 17/6/9.
//  Copyright © 2017年 Hy. All rights reserved.
//

#import "UITableView+HyExtension.h"
#import "HyRunTimeMethods.h"

@interface HyTableViewDelegateConfigure () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,copy) NSInteger(^numberOfSections)(UITableView *tableView);
@property (nonatomic,copy) NSInteger(^numberOfRowsInSection)(UITableView *tableView, NSInteger section);
// cell
@property (nonatomic,copy) UITableViewCell *(^cellForRowAtIndexPath)(UITableView *tableView, NSIndexPath * indexPath);
@property (nonatomic,copy) CGFloat (^heightForRowAtIndexPath)(UITableView *tableView, NSIndexPath * indexPath);
@property (nonatomic,copy) void (^didSelectRowAtIndexPath)(UITableView *tableView, NSIndexPath * indexPath);
@property (nonatomic,copy) void (^didDeselectRowAtIndexPath)(UITableView *tableView, NSIndexPath * indexPath);
@property (nonatomic,copy) void (^willDisplayCell)(UITableView *tableView,UITableViewCell *cell, NSIndexPath * indexPath);
// sectionHeader
@property (nonatomic,copy) CGFloat (^heightForHeaderInSection)(UITableView *tableView,NSInteger section);
@property (nonatomic,copy) UIView *(^viewForHeaderInSection)(UITableView *tableView,NSInteger section);
@property (nonatomic,copy) void (^willDisplayHeaderView)(UITableView *tableView,UIView *view,NSInteger section);
// sectionFooter
@property (nonatomic,copy) CGFloat (^heightForFooterInSection)(UITableView *tableView,NSInteger section);
@property (nonatomic,copy) UIView *(^viewForFooterInSection)(UITableView *tableView,NSInteger section);
@property (nonatomic,copy) void (^willDisplayFooterView)(UITableView *tableView,UIView *view,NSInteger section);
//Edit
@property (nonatomic,copy) BOOL (^canEditRowAtIndexPath)(UITableView *tableView, NSIndexPath * indexPath);
@property (nonatomic,copy) UITableViewCellEditingStyle
(^editingStyleForRowAtIndexPath)(UITableView *tableView, NSIndexPath * indexPath);
@property (nonatomic,copy) void (^commitEditingStyle)
(UITableView *tableView,UITableViewCellEditingStyle editingStyle ,NSIndexPath * indexPath);
@property (nonatomic,copy) NSArray<UITableViewRowAction *> *
(^editActionsForRowAtIndexPath)(UITableView *tableView ,NSIndexPath * indexPath);
@property (nonatomic,copy) BOOL (^canMoveRowAtIndexPath)(UITableView *tableView ,NSIndexPath * indexPath);
@property (nonatomic,copy) BOOL (^shouldIndentWhileEditingRowAtIndexPath)(UITableView *tableView ,NSIndexPath * indexPath);
@property (nonatomic,copy) NSIndexPath *(^targetIndexPathForMoveFromRowAtIndexPath)(UITableView *tableView, NSIndexPath *sourceIndexPath , NSIndexPath *toProposedIndexPath);
@property (nonatomic,copy) void (^moveRowAtIndexPath)(UITableView *tableView, NSIndexPath * sourceIndexPath,  NSIndexPath * destinationIndexPath);
@property (nonatomic,copy) NSArray<NSString *> *(^sectionAndCellDataKey)(void);
@property (nonatomic,copy) Class(^cellClassForRow)(id cellData, NSIndexPath * indexPath);
@property (nonatomic,copy) void(^cellWithData)(UITableViewCell *cell, id cellData, NSIndexPath *indexPath);
@property (nonatomic,copy) Class(^sectionHeaderFooterViewClassAtSection)(id sectionData,
                                                                  HyTableSeactionViewKinds seactionViewKinds,
                                                                  NSUInteger section);
@property (nonatomic,copy) void(^sectionHeaderFooterViewWithSectionData)(UIView *headerFooterView,
                                                                        id sectionData,
                                                                        HyTableSeactionViewKinds seactionViewKinds,
                                                                        NSUInteger section);
@property (nonatomic,copy) void(^emtyViewBlock)(UITableView *,UIView *);
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,copy) NSString *cellDataKey;
@property (nonatomic,copy) NSString *sectionDataKey;
@property (nonatomic,strong) NSArray<Class> *cellClasses;
@property (nonatomic,strong) NSArray<Class> *headerFooterViewClasses;
@end
@implementation HyTableViewDelegateConfigure

- (HyTableViewDelegateConfigure *(^)(NSInteger (^)(UITableView *)))configNumberOfSections {
    __weak typeof(self) _self = self;
    return ^(NSInteger (^block)(UITableView *)) {
        __strong typeof(_self) self = _self;
        self.numberOfSections = [block copy];
        return self;
    };
}
- (HyTableViewDelegateConfigure *(^)(NSInteger (^)(UITableView *, NSInteger)))configNumberOfRowsInSection {
    __weak typeof(self) _self = self;
    return ^(NSInteger (^block)(UITableView *, NSInteger)) {
        __strong typeof(_self) self = _self;
        self.numberOfRowsInSection = [block copy];
        return self;
    };
}
- (HyTableViewDelegateConfigure *(^)(UITableViewCell *(^)(UITableView *, NSIndexPath *)))configCellForRowAtIndexPath {
    __weak typeof(self) _self = self;
    return ^(UITableViewCell *(^block)(UITableView *, NSIndexPath *)) {
        __strong typeof(_self) self = _self;
        self.cellForRowAtIndexPath = [block copy];
        return self;
    };
}
- (HyTableViewDelegateConfigure *(^)(CGFloat (^)(UITableView *, NSIndexPath *)))configHeightForRowAtIndexPath {
    __weak typeof(self) _self = self;
    return ^id(CGFloat (^block)(UITableView *, NSIndexPath *)) {
        __strong typeof(_self) self = _self;
        self.heightForRowAtIndexPath = [block copy];
        return self.addDelegateMethod(@"tableView:withView:heightForRowAtIndexPath:", ^id {
            return ^CGFloat(HyTableViewDelegateConfigure *_self, UITableView *_tableView, NSIndexPath *indexPath) {
               return
                _self.heightForRowAtIndexPath ?
                _self.heightForRowAtIndexPath(_tableView, indexPath) : _tableView.rowHeight;
            };
        });
    };
}
- (HyTableViewDelegateConfigure *(^)(void (^)(UITableView *, UITableViewCell *, NSIndexPath *)))configWillDisplayCell {
    __weak typeof(self) _self = self;
    return ^id(void (^block)(UITableView *, UITableViewCell *, NSIndexPath *)) {
        __strong typeof(_self) self = _self;
        self.willDisplayCell = [block copy];
        return self.addDelegateMethod(@"tableView:withView:willDisplayCell:forRowAtIndexPath:", ^id {
            return ^(HyTableViewDelegateConfigure *_self, UITableView *_tableView, UITableViewCell *cell,  NSIndexPath *indexPath) {
                _self.willDisplayCell ?
                _self.willDisplayCell(_tableView, cell, indexPath) : nil;
            };
        });
    };
}
- (HyTableViewDelegateConfigure *(^)(void (^)(UITableView *, NSIndexPath *)))configDidSelectRowAtIndexPath {
    __weak typeof(self) _self = self;
    return ^id(void (^block)(UITableView *, NSIndexPath *)) {
        __strong typeof(_self) self = _self;
        self.didSelectRowAtIndexPath = [block copy];
        return self.addDelegateMethod(@"tableView:didSelectRowAtIndexPath:", ^id {
            return ^(HyTableViewDelegateConfigure *_self, UITableView *_tableView, UITableViewCell *cell,  NSIndexPath *indexPath) {
                !_self.didSelectRowAtIndexPath ?:
                _self.didSelectRowAtIndexPath(_tableView, indexPath);
            };
        });
    };
}
- (HyTableViewDelegateConfigure *(^)(void (^)(UITableView *, NSIndexPath *)))configDidDeselectRowAtIndexPath {
    __weak typeof(self) _self = self;
    return ^id(void (^block)(UITableView *, NSIndexPath *)){
        __strong typeof(_self) self = _self;
        self.didDeselectRowAtIndexPath = [block copy];
        return self.addDelegateMethod(@"tableView:withView:didDeselectRowAtIndexPath:", ^id {
            return ^(HyTableViewDelegateConfigure *_self, UITableView *_tableView, NSIndexPath *indexPath) {
                _self.didDeselectRowAtIndexPath ?
                _self.didDeselectRowAtIndexPath(_tableView, indexPath) : nil;
            };
        });
    };
}



- (HyTableViewDelegateConfigure *(^)(UIView *(^)(UITableView *, NSInteger)))configViewForHeaderInSection {
    __weak typeof(self) _self = self;
    return ^id(UIView *(^block)(UITableView *, NSInteger)) {
        __strong typeof(_self) self = _self;
        self.viewForHeaderInSection = [block copy];
        return self.addDelegateMethod(@"tableView:viewForHeaderInSection:", ^id {
            return ^UIView * (HyTableViewDelegateConfigure *_self, UITableView *_tableView, NSInteger section) {
                
               UIView *view;
               if (_self.viewForHeaderInSection) {
                       view = _self.viewForHeaderInSection(_tableView, section);
                } else {
                       id headerClass;
                       id sectionData = [_self getSectionDtaAtSection:section];
                       if (_self.sectionHeaderFooterViewClassAtSection) {
                           headerClass = _self.sectionHeaderFooterViewClassAtSection(sectionData,0, section);;
                       } else {
                           NSArray *array = _self.headerFooterViewClasses;
                           if (array.count == 1) {
                               headerClass = array.firstObject;
                           };
                       }
               
                       if (class_isMetaClass(object_getClass(headerClass))) {
                           view =
                           [headerClass hy_headerFooterViewWithTableView:_tableView
                                                                 section:section
                                                       seactionViewKinds:HyTableSeactionViewKindsHeader
                                                             sectionData:sectionData];
               
                       } else if ([headerClass isKindOfClass:UIView.class]) {
                           view = headerClass;
                       };
                }
               if (view) {
                  self.sectionHeaderFooterViewWithSectionData ?
                   self.sectionHeaderFooterViewWithSectionData(view,
                                                               [self getSectionDtaAtSection:section],
                                                               HyTableSeactionViewKindsHeader,
                                                               section) : nil;
                   if ([view isKindOfClass:UITableViewHeaderFooterView.class]) {
                       [((UITableViewHeaderFooterView *)view) hy_reloadHeaderFooterViewData];
                   }
               }
               return view;
            };
        });
    
    };
}
- (HyTableViewDelegateConfigure *(^)(CGFloat (^)(UITableView *, NSInteger)))configHeightForHeaderInSection {
    __weak typeof(self) _self = self;
    return ^id(CGFloat (^block)(UITableView *, NSInteger)) {
        __strong typeof(_self) self = _self;
        self.heightForHeaderInSection = [block copy];
        return self.addDelegateMethod(@"heightForHeaderInSection:", ^id {
            return ^CGFloat(HyTableViewDelegateConfigure *_self, UITableView *_tableView,  NSInteger section) {
               return
               _self.heightForHeaderInSection ?
               _self.heightForHeaderInSection(_tableView, section) : (_tableView.sectionHeaderHeight > 0 ? _tableView.sectionHeaderHeight : CGFLOAT_MIN);
            };
        });
    };
}
- (HyTableViewDelegateConfigure *(^)(void (^)(UITableView *, UIView *, NSInteger)))configWillDisplayHeaderView {
    __weak typeof(self) _self = self;
    return ^id (void (^block)(UITableView *, UIView *, NSInteger)) {
        __strong typeof(_self) self = _self;
        self.willDisplayHeaderView = [block copy];
        return self.addDelegateMethod(@"tableView:willDisplayHeaderView:forSection:", ^id {
            return ^(HyTableViewDelegateConfigure *_self, UITableView *_tableView, UIView *view,  NSInteger section) {
                _self.willDisplayHeaderView ?
                _self.willDisplayHeaderView(_tableView, view,section) : nil;
            };
        });
    };
}


- (HyTableViewDelegateConfigure *(^)(UIView *(^)(UITableView *, NSInteger)))configViewForFooterInSection {
    __weak typeof(self) _self = self;
    return ^id (UIView *(^block)(UITableView *, NSInteger)) {
        __strong typeof(_self) self = _self;
        self.viewForFooterInSection = [block copy];
        return self.addDelegateMethod(@"tableView:viewForHeaderInSection:", ^id {
            return ^UIView * (HyTableViewDelegateConfigure *_self, UITableView *_tableView, NSInteger section) {
                
                UIView *view;
                if (_self.viewForFooterInSection) {
                    view = _self.viewForFooterInSection(_tableView, section);
                } else {
                    id footerClass;
                    id sectionData = [_self getSectionDtaAtSection:section];
                    if (_self.sectionHeaderFooterViewClassAtSection) {
                        footerClass = _self.sectionHeaderFooterViewClassAtSection(sectionData,0, section);;
                    } else {
                        NSArray *array = _self.headerFooterViewClasses;
                        if (array.count == 1) {
                            footerClass = array.firstObject;
                        };
                    }

                    if (class_isMetaClass(object_getClass(footerClass))) {
                        view =
                        [footerClass hy_headerFooterViewWithTableView:_tableView
                                                              section:section
                                                    seactionViewKinds:HyTableSeactionViewKindsFooter
                                                          sectionData:sectionData];

                    } else if ([footerClass isKindOfClass:UIView.class]) {
                        view = footerClass;
                    }
                }
                
                if (view) {
                    _self.sectionHeaderFooterViewWithSectionData ?
                    _self.sectionHeaderFooterViewWithSectionData(view,
                                                                [_self getSectionDtaAtSection:section],
                                                                HyTableSeactionViewKindsHeader,
                                                                section) : nil;
                    if ([view isKindOfClass:UITableViewHeaderFooterView.class]) {
                        [((UITableViewHeaderFooterView *)view) hy_reloadHeaderFooterViewData];
                    }
                }
                return view;
            };
        });
    };
}
- (HyTableViewDelegateConfigure *(^)(CGFloat (^)(UITableView *, NSInteger)))configHeightForFooterInSection {
    __weak typeof(self) _self = self;
    return ^id(CGFloat (^block)(UITableView *, NSInteger)) {
        __strong typeof(_self) self = _self;
        self.heightForFooterInSection = [block copy];
        return self.addDelegateMethod(@"tableView:heightForFooterInSection:", ^id {
            return ^CGFloat(HyTableViewDelegateConfigure *_self, UITableView *_tableView, NSInteger section) {
               return
                _self.heightForFooterInSection ?
                _self.heightForFooterInSection(_tableView, section) : (_tableView.sectionFooterHeight > 0 ? _tableView.sectionFooterHeight : CGFLOAT_MIN);
            };
        });
    };
}
- (HyTableViewDelegateConfigure *(^)(void (^)(UITableView *, UIView *, NSInteger)))configWillDisplayFooterView {
    __weak typeof(self) _self = self;
    return ^id(void (^block)(UITableView *, UIView *, NSInteger)) {
        __strong typeof(_self) self = _self;
        self.willDisplayFooterView = [block copy];
        return self.addDelegateMethod(@"tableView:willDisplayFooterView:forSection:", ^id {
            return ^(HyTableViewDelegateConfigure *_self, UITableView *_tableView, UIView *view,  NSInteger section) {
                _self.willDisplayFooterView ?
                _self.willDisplayFooterView(_tableView, view,section) : nil;
            };
        });
    };
}


- (HyTableViewDelegateConfigure *(^)(BOOL (^)(UITableView *, NSIndexPath *)))configCanEditRowAtIndexPath {
    __weak typeof(self) _self = self;
    return ^id(BOOL (^block)(UITableView *, NSIndexPath *)) {
        __strong typeof(_self) self = _self;
        self.canEditRowAtIndexPath = [block copy];
        return self.addDelegateMethod(@"tableView:canEditRowAtIndexPath:", ^id {
            return ^BOOL(HyTableViewDelegateConfigure *_self, UITableView *_tableView, NSIndexPath *indexPath) {
               return
                _self.canEditRowAtIndexPath ?
                _self.canEditRowAtIndexPath(_tableView, indexPath) : NO;
            };
        });
    };
}
- (HyTableViewDelegateConfigure *(^)(UITableViewCellEditingStyle (^)(UITableView *, NSIndexPath *)))configEditingStyleForRowAtIndexPath {
    __weak typeof(self) _self = self;
    return ^id(UITableViewCellEditingStyle (^block)(UITableView *, NSIndexPath *)) {
        __strong typeof(_self) self = _self;
        self.editingStyleForRowAtIndexPath = [block copy];
        return self.addDelegateMethod(@"tableView:editingStyleForRowAtIndexPath:", ^id {
            return ^UITableViewCellEditingStyle(HyTableViewDelegateConfigure *_self, UITableView *_tableView, NSIndexPath *indexPath) {
               return
                _self.editingStyleForRowAtIndexPath ?
                _self.editingStyleForRowAtIndexPath(_tableView, indexPath) : 0;
            };
        });
    };
}
- (HyTableViewDelegateConfigure *(^)(UITableViewCellEditingStyle (^)(UITableView *, UITableViewCellEditingStyle, NSIndexPath *)))configCommitEditingStyle {
    __weak typeof(self) _self = self;
    return ^id(UITableViewCellEditingStyle (^block)(UITableView *, UITableViewCellEditingStyle, NSIndexPath *)){
        __strong typeof(_self) self = _self;
        self.commitEditingStyle = [block copy];
        return self.addDelegateMethod(@"tableView:commitEditingStyle:forRowAtIndexPath:", ^id {
            return ^(HyTableViewDelegateConfigure *_self, UITableView *_tableView, UITableViewCellEditingStyle editingStyle, NSIndexPath *indexPath) {
               _self.commitEditingStyle ?
               _self.commitEditingStyle(_tableView, editingStyle, indexPath) : 0;
            };
        });
    };
}
- (HyTableViewDelegateConfigure *(^)(NSArray<UITableViewRowAction *> *(^)(UITableView *, NSIndexPath *)))configEditActionsForRowAtIndexPath {
    __weak typeof(self) _self = self;
    return ^id(NSArray<UITableViewRowAction *> *(^block)(UITableView *, NSIndexPath *)){
        __strong typeof(_self) self = _self;
        self.editActionsForRowAtIndexPath = [block copy];
        return self.addDelegateMethod(@"tableView:editActionsForRowAtIndexPath:", ^id {
            return ^NSArray<UITableViewRowAction *> *(HyTableViewDelegateConfigure *_self, UITableView *_tableView, NSIndexPath *indexPath) {
               return
               _self.editActionsForRowAtIndexPath ?
               _self.editActionsForRowAtIndexPath(_tableView, indexPath) : nil;
            };
        });
    };
}
- (HyTableViewDelegateConfigure *(^)(BOOL (^)(UITableView *, NSIndexPath *)))configShouldIndentWhileEditingRowAtIndexPath {
    __weak typeof(self) _self = self;
    return ^id (BOOL (^block)(UITableView *, NSIndexPath *)) {
        __strong typeof(_self) self = _self;
        self.shouldIndentWhileEditingRowAtIndexPath = [block copy];
        return self.addDelegateMethod(@"tableView:shouldIndentWhileEditingRowAtIndexPath:", ^id {
            return ^BOOL(HyTableViewDelegateConfigure *_self, UITableView *_tableView, NSIndexPath *indexPath) {
               return
               _self.shouldIndentWhileEditingRowAtIndexPath ?
               _self.shouldIndentWhileEditingRowAtIndexPath(_tableView, indexPath) : YES;
            };
        });
    };
}

- (HyTableViewDelegateConfigure *(^)(BOOL (^)(UITableView *, NSIndexPath *)))configCanMoveRowAtIndexPath {
    __weak typeof(self) _self = self;
    return ^id(BOOL (^block)(UITableView *, NSIndexPath *)) {
        __strong typeof(_self) self = _self;
        self.canMoveRowAtIndexPath = [block copy];
        return self.addDelegateMethod(@"tableView:canMoveRowAtIndexPath:", ^id {
            return ^BOOL(HyTableViewDelegateConfigure *_self, UITableView *_tableView, NSIndexPath *indexPath) {
               return
               _self.canMoveRowAtIndexPath ?
               _self.canMoveRowAtIndexPath(_tableView, indexPath) : NO;
            };
        });
    };
}
- (HyTableViewDelegateConfigure *(^)(NSIndexPath *(^)(UITableView *, NSIndexPath *, NSIndexPath *)))configTargetIndexPathForMoveFromRowAtIndexPath {
    __weak typeof(self) _self = self;
    return ^id(NSIndexPath *(^block)(UITableView *, NSIndexPath *, NSIndexPath *)) {
        __strong typeof(_self) self = _self;
        self.targetIndexPathForMoveFromRowAtIndexPath = [block copy];
        return self.addDelegateMethod(@"tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:", ^id {
            return ^NSIndexPath *(HyTableViewDelegateConfigure *_self, UITableView *_tableView, NSIndexPath *sourceIndexPath, NSIndexPath *proposedDestinationIndexPath) {
               return
               _self.targetIndexPathForMoveFromRowAtIndexPath ?
               _self.targetIndexPathForMoveFromRowAtIndexPath
               (_tableView, sourceIndexPath, proposedDestinationIndexPath) : proposedDestinationIndexPath;;
            };
        });
    };
}
- (HyTableViewDelegateConfigure *(^)(void (^)(UITableView *, NSIndexPath *, NSIndexPath *)))configMoveRowAtIndexPath {
    __weak typeof(self) _self = self;
    return ^id(void (^block)(UITableView *, NSIndexPath *, NSIndexPath *)){
        __strong typeof(_self) self = _self;
        self.moveRowAtIndexPath = [block copy];
        return self.addDelegateMethod(@"tableView:moveRowAtIndexPath:toIndexPath:", ^id {
            return ^(HyTableViewDelegateConfigure *_self, UITableView *_tableView, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath) {
               !_self.moveRowAtIndexPath ?:
               _self.moveRowAtIndexPath(_tableView, sourceIndexPath, destinationIndexPath);
            };
        });
    };
}


- (HyTableViewDelegateConfigure *(^)(NSArray<NSString *> *(^)(void)))configSectionAndCellDataKey {
    __weak typeof(self) _self = self;
    return ^(NSArray<NSString *> *(^block)(void)){
        __strong typeof(_self) self = _self;
        self.sectionAndCellDataKey = [block copy];
        return self;
    };
}

- (HyTableViewDelegateConfigure *(^)(Class (^)(id, NSIndexPath *)))configCellClassForRow {
    __weak typeof(self) _self = self;
    return ^(Class (^block)(id, NSIndexPath *)){
        __strong typeof(_self) self = _self;
        self.cellClassForRow = [block copy];
        return self;
    };
}


- (HyTableViewDelegateConfigure *(^)(void (^)(UITableViewCell *, id, NSIndexPath *)))configCellWithData {
    __weak typeof(self) _self = self;
    return ^(void (^block)(UITableViewCell *, id, NSIndexPath *)){
        __strong typeof(_self) self = _self;
        self.cellWithData = [block copy];
        return self;
    };
}

- (HyTableViewDelegateConfigure *(^)(Class (^)(id, HyTableSeactionViewKinds, NSUInteger)))configSectionHeaderFooterViewClassAtSection {
    __weak typeof(self) _self = self;
    return ^(Class (^block)(id, HyTableSeactionViewKinds, NSUInteger)){
        __strong typeof(_self) self = _self;
        self.sectionHeaderFooterViewClassAtSection = [block copy];
        return self;
    };
}

- (HyTableViewDelegateConfigure *(^)(void (^)(UIView *, id, HyTableSeactionViewKinds, NSUInteger)))configSectionHeaderFooterViewWithSectionData {
    __weak typeof(self) _self = self;
    return ^(void (^block)(UIView *, id, HyTableSeactionViewKinds, NSUInteger)){
        __strong typeof(_self) self = _self;
        self.sectionHeaderFooterViewWithSectionData = [block copy];
        return self;
    };
}

- (HyTableViewDelegateConfigure *(^)(void (^)(UITableView *, UIView *)))configEmtyView {
    __weak typeof(self) _self = self;
    return ^(void (^block)(UITableView *, UIView *)){
        __strong typeof(_self) self = _self;
        self.emtyViewBlock = [block copy];
        return self;
    };
}


#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return
    self.numberOfSections ?
    self.numberOfSections(tableView) : [self getSectionCount];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return
    self.numberOfRowsInSection ?
    self.numberOfRowsInSection(tableView, section) : [self getCellCountInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    if (self.cellForRowAtIndexPath) {
        cell = self.cellForRowAtIndexPath(tableView, indexPath);
    } else {
        
        Class cellClass;
        id cellData = [self getCellDataAtIndexPath:indexPath];
        if (self.cellClassForRow) {
            cellClass = self.cellClassForRow(cellData ,indexPath);
        } else {
            NSArray *array = self.cellClasses;
            if (array.count == 1) {
                cellClass = array.firstObject;
            };
        }
        cell =
        cellClass ? [cellClass hy_cellWithTableView:tableView
                                          indexPath:indexPath
                                           cellData:cellData] : nil;
    }
    if (cell) {
        self.cellWithData ?
        self.cellWithData(cell, [self getCellDataAtIndexPath:indexPath], indexPath) : nil;
        [cell hy_reloadCellData];
    }
    return cell;
}

- (NSInteger)getSectionCount {
    
    id sectionData = [self getSectionData];
    if ([self isArrayWithData:sectionData]) {
        return ((NSArray *)sectionData).count;
    }
    
    if ([self isArrayWithData:self.hy_tableViewData] &&
        ![self getSectionKey].length && [self getCellKey].length) {
        return ((NSArray *)self.hy_tableViewData).count;
    }
    
    return self.hy_tableViewData ? 1 : 0;
}

- (NSInteger)getCellCountInSection:(NSInteger)section {
    
    id cellData = [self getCellKeyDataWithSection:section];
    if ([self isArrayWithData:cellData]) {
        return ((NSArray *)cellData).count;
    }
    
    if ([self isArrayWithData:self.hy_tableViewData] &&
        ![self getSectionKey].length && ![self getCellKey].length) {
        return ((NSArray *)self.hy_tableViewData).count;
    }
    
    return self.hy_tableViewData ? 1 : 0;
}

- (id)getCellDataAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!indexPath) { return nil;}
    
    id cellData = [self getCellKeyDataWithSection:indexPath.section];
    if ([self isArrayWithData:cellData]) {
        if (((NSArray *)cellData).count > indexPath.row) {
            return ((NSArray *)cellData)[indexPath.row];
        }
    }
    
    if ([self isArrayWithData:self.hy_tableViewData] &&
        ![self getSectionKey].length && ![self getCellKey].length) {
        if (((NSArray *)self.hy_tableViewData).count > indexPath.row) {
            return ((NSArray *)self.hy_tableViewData)[indexPath.row];
        }
    }
    
    return self.hy_tableViewData;
}

- (id)getSectionDtaAtSection:(NSInteger)section {
    
    id sectionData = [self getSectionData];
    if ([self isArrayWithData:sectionData]) {
        if (((NSArray *)sectionData).count > section) {
            return ((NSArray *)sectionData)[section];
        }
    }
    
    if ([self isArrayWithData:self.hy_tableViewData] &&
        ![self getSectionKey].length && [self getCellKey].length) {
        if (((NSArray *)self.hy_tableViewData).count > section) {
            return ((NSArray *)self.hy_tableViewData)[section];
        }
    }
    
    return self.hy_tableViewData;
}

- (id)getSectionData {
    
    NSString *sectionKey = [self getSectionKey];
    if (sectionKey.length && sectionKey.length) {
        NSArray *keys = [sectionKey componentsSeparatedByString:@"."];
        id data = self.hy_tableViewData;
        for (NSString *key in keys) {
            if ([self isObjectWithData:data]) {
                data = [data valueForKeyPath:key];
            }
        }
        return data;
    }
    return nil;
}

- (id)getCellKeyDataWithSection:(NSInteger)section {
    
    NSString *cellKey = [self getCellKey];
    if (self.hy_tableViewData && cellKey.length) {
        
        id sectionData = [self getSectionData] ?: self.hy_tableViewData;
        id cellData = sectionData;
        if ([self isArrayWithData:sectionData]) {
            if (section < ((NSArray *)sectionData).count) {
                cellData = ((NSArray *)sectionData)[section];
            } else {
                return @[].mutableCopy;
            }
        }
        
        if ([self isObjectWithData:cellData]) {
            
            NSArray *keys = [cellKey componentsSeparatedByString:@"."];
            if (keys.count) {
                id data = cellData;
                for (NSString *key in keys) {
                    if (key.length && [self isObjectWithData:data]) {
                        data = [data valueForKeyPath:key];
                    }
                }
                return data;
            } else {
                return cellData;
            }
        }
    }
    return nil;
}

- (NSString *)getSectionKey {
    if (self.sectionAndCellDataKey) {
        return self.sectionAndCellDataKey().firstObject;
    }
    return self.sectionDataKey;
}

- (NSString *)getCellKey {
    if (self.sectionAndCellDataKey) {
        return self.sectionAndCellDataKey().lastObject;
    }
    return self.cellDataKey;
}

- (BOOL)isArrayWithData:(id)data {
    if ([data isKindOfClass:NSArray.class] ||
        [data isKindOfClass:NSMutableArray.class]) {
        return YES;
    }
    return NO;
}

- (BOOL)isObjectWithData:(id)data {
    if (!data) { return NO;}
    
    return ![self isArrayWithData:data];
}

- (id)hy_tableViewData {
    return self.tableView.hy_tableViewData;
}

- (void)dealloc {
    if (![self isMemberOfClass:HyTableViewDelegateConfigure.class] &&
        [NSStringFromClass(self.class) hasSuffix:@"HyTableViewDelegateConfigure_"]) {
        Class cls = self.class;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            objc_disposeClassPair(cls);
        });
    }
}
@end


@interface UITableView ()
@property (nonatomic,strong) HyTableViewDelegateConfigure *hy_delegateConfigure;
@end
@implementation UITableView (HyExtension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hy_swizzleInstanceMethods([self class],@[@"reloadData"]);
    });
}

+ (instancetype)hy_tableViewWithFrame:(CGRect)frame
                                style:(UITableViewStyle)style
                          cellClasses:(NSArray<Class> *)cellClasses
              headerFooterViewClasses:(NSArray<Class> *)headerFooterViewClasses
                           dataSource:(id<UITableViewDataSource>)dataSource
                             delegate:(id<UITableViewDelegate>)delegate {
    
    UITableView *tableView = [[self alloc] initWithFrame:frame style:style];
    if (@available(iOS 11.0, *)){
        tableView.estimatedRowHeight = CGFLOAT_MIN;
        tableView.estimatedSectionHeaderHeight = CGFLOAT_MIN;
        tableView.estimatedSectionFooterHeight = CGFLOAT_MIN;
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [tableView hy_registerCellWithCellClasses:cellClasses];
    [tableView hy_registerHeaderFooterWithViewClasses:headerFooterViewClasses];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    tableView.dataSource = dataSource;
    tableView.delegate = delegate;
    [tableView hy_tableViewLoad];
    return tableView;
}

+ (instancetype)hy_tableViewWithFrame:(CGRect)frame
                                style:(UITableViewStyle)style
                        tableViewData:(id)tableViewData
                          cellClasses:(NSArray<Class> *)cellClasses
              headerFooterViewClasses:(NSArray<Class> *)headerFooterViewClasses
                    delegateConfigure:(void (^)(HyTableViewDelegateConfigure *configure))delegateConfigure {
    
    UITableView *tableView = [[self alloc] initWithFrame:frame style:style];
    if (@available(iOS 11.0, *)){
        tableView.estimatedRowHeight = CGFLOAT_MIN;
        tableView.estimatedSectionHeaderHeight = CGFLOAT_MIN;
        tableView.estimatedSectionFooterHeight = CGFLOAT_MIN;
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    tableView.hy_tableViewData = tableViewData;
    [tableView hy_registerCellWithCellClasses:cellClasses];
    [tableView hy_registerHeaderFooterWithViewClasses:headerFooterViewClasses];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    tableView.hy_delegateConfigure = tableView.delegateInstance;
    !delegateConfigure ?: delegateConfigure(tableView.hy_delegateConfigure);
    tableView.hy_delegateConfigure.tableView = tableView;
    tableView.hy_delegateConfigure.cellClasses = cellClasses;
    tableView.hy_delegateConfigure.headerFooterViewClasses = headerFooterViewClasses;
    tableView.dataSource = tableView.hy_delegateConfigure;
    tableView.delegate = tableView.hy_delegateConfigure;
    [tableView hy_tableViewLoad];
    return tableView;
}

- (HyTableViewDelegateConfigure *)delegateInstance {
    const char *clasName = [[NSString stringWithFormat:@"HyTableViewDelegateConfigure_%d_%d", arc4random() % 100, arc4random() % 100] cStringUsingEncoding:NSASCIIStringEncoding];
    if (!objc_getClass(clasName)){
        objc_registerClassPair(objc_allocateClassPair(HyTableViewDelegateConfigure.class, clasName, 0));
        return [[objc_getClass(clasName) alloc] init];;
    } else {
        return [self delegateInstance];
    }
}

- (void)hy_tableViewLoad {};
- (void)hy_reloadDataWithSectionDataKey:(NSString *)sectionDataKey
                            cellDataKey:(NSString *)cellDataKey {
    
    self.hy_delegateConfigure.sectionDataKey = sectionDataKey;
    self.hy_delegateConfigure.cellDataKey = cellDataKey;
    [self reloadData];
}

- (id)hy_sectionDataAtSection:(NSInteger)section {
    if (self.hy_delegateConfigure) {
        [self.hy_delegateConfigure getSectionDtaAtSection:section];
    }
    return nil;
}

- (id)hy_cellDataAtIndexPath:(NSIndexPath *)indexPath {
    if (self.hy_delegateConfigure) {
        [self.hy_delegateConfigure getCellDataAtIndexPath:indexPath];
    }
    return nil;
}

- (BOOL)hy_cellIsVisibleAtIndexPath:(NSIndexPath *)indexPath {
    NSArray<NSIndexPath *> *visibleCellIndexPaths = self.indexPathsForVisibleRows;
    for (NSIndexPath *visibleIndexPath in visibleCellIndexPaths) {
        if ([indexPath isEqual:visibleIndexPath]) {
            return YES;
        }
    }
    return NO;
}

- (void)hy_insertSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation {
    if (section > self.numberOfSections - 1) {
        return;
    }
    NSIndexSet *sections = [NSIndexSet indexSetWithIndex:section];
    [self insertSections:sections withRowAnimation:animation];
}

- (void)hy_deleteSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation {
    if (section > self.numberOfSections - 1) {
        return;
    }
    NSIndexSet *sections = [NSIndexSet indexSetWithIndex:section];
    [self deleteSections:sections withRowAnimation:animation];
}

- (void)hy_reloadSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation {
    if (section > self.numberOfSections - 1) {
        return;
    }
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
    [self reloadSections:indexSet withRowAnimation:animation];
}

- (void)hy_clearSelectedRowsAnimated:(BOOL)animated {
    NSArray *indexs = [self indexPathsForSelectedRows];
    [indexs enumerateObjectsUsingBlock:^(NSIndexPath* path, NSUInteger idx, BOOL *stop) {
        [self deselectRowAtIndexPath:path animated:animated];
    }];
}

- (void)hy_reloadData {
    
    if (self.hy_willReloadDataAsynHandler) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            self.hy_willReloadDataAsynHandler(self);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hy_handleReloadData];
            });
        });
    } else {
        [self hy_handleReloadData];
    }
}

- (void)hy_handleReloadData {
    !self.hy_willReloadDataHandler ?: self.hy_willReloadDataHandler(self);
    [self hy_reloadData];
    
    if (self.hy_delegateConfigure.emtyViewBlock) {
           
           NSInteger sectionCount =
           self.hy_delegateConfigure.numberOfSections ?
           self.hy_delegateConfigure.numberOfSections(self) :
           [self.hy_delegateConfigure getSectionCount];
           
           if (sectionCount <= 1) {
               
               NSInteger cellCount =
               self.hy_delegateConfigure.numberOfRowsInSection ?
               self.hy_delegateConfigure.numberOfRowsInSection(self, 0) :
               [self.hy_delegateConfigure getCellCountInSection:0];
               
               if (cellCount == 0) {
                   self.hy_emtyContainerView.hidden = NO;
                   [self.hy_emtyContainerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                   self.hy_delegateConfigure.emtyViewBlock(self,self.hy_emtyContainerView);
               } else {
                   self.hy_emtyContainerView.hidden = YES;
               }
           } else {
               self.hy_emtyContainerView.hidden = YES;
           }
       }
    
    !self.hy_didReloadDataHandler ?: self.hy_didReloadDataHandler(self);
}

- (void)hy_registerCellWithCellClasses:(NSArray<Class> *)cellClasses {
    
    if (!cellClasses.count) { return; }
    [cellClasses enumerateObjectsUsingBlock:^(Class obj,
                                              NSUInteger idx,
                                              BOOL *stop) {
        [self hy_registerCellWithCellClass:obj];
    }];
}

- (void)hy_registerCellWithCellClass:(Class)cellClass {
    
    if (!cellClass) { return; }
    
    NSString *cellClassString = NSStringFromClass(cellClass);
    NSString *nibPath = [[NSBundle mainBundle] pathForResource:cellClassString ofType:@"nib"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:nibPath]) {
        [self registerNib:[UINib nibWithNibName:cellClassString
                                         bundle:nil] forCellReuseIdentifier:cellClassString];
    } else {
        [self registerClass:cellClass forCellReuseIdentifier:cellClassString];
    }
}

- (void)hy_registerHeaderFooterWithViewClasses:(NSArray<Class> *)viewClasses {
    
    if (!viewClasses.count) { return; }
    [viewClasses enumerateObjectsUsingBlock:^(Class obj,
                                              NSUInteger idx,
                                              BOOL *stop) {
        [self hy_registerHeaderFooterWithViewClass:obj];
    }];
}

- (void)hy_registerHeaderFooterWithViewClass:(Class)viewClass {
    
    if (!viewClass) { return; }
    
    NSString *viewClassString = NSStringFromClass(viewClass);
    NSString *nibPath =  [[NSBundle mainBundle] pathForResource:viewClassString ofType:@"nib"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:nibPath]) {
        [self registerNib:[UINib nibWithNibName:viewClassString
                                         bundle:nil] forHeaderFooterViewReuseIdentifier:viewClassString];
    }else{
        [self registerClass:viewClass forHeaderFooterViewReuseIdentifier:viewClassString];
    }
}

- (void)setHy_delegateConfigure:(HyTableViewDelegateConfigure *)hy_delegateConfigure {
    objc_setAssociatedObject(self,
                             @selector(hy_delegateConfigure),
                             hy_delegateConfigure,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (HyTableViewDelegateConfigure *)hy_delegateConfigure {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHy_tableViewData:(id)hy_tableViewData {
    objc_setAssociatedObject(self,
                             @selector(hy_tableViewData),
                             hy_tableViewData,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)hy_tableViewData {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHy_willReloadDataAsynHandler:(void (^)(UITableView *tableView))hy_willReloadDataAsynHandler {
    objc_setAssociatedObject(self,
                             @selector(hy_willReloadDataAsynHandler),
                             hy_willReloadDataAsynHandler,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UITableView *tableView))hy_willReloadDataAsynHandler {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHy_willReloadDataHandler:(void (^)(UITableView *tableView))hy_willReloadDataHandler {
    objc_setAssociatedObject(self,
                             @selector(hy_willReloadDataHandler),
                             hy_willReloadDataHandler,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UITableView *tableView))hy_willReloadDataHandler {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHy_didReloadDataHandler:(void (^)(UITableView *tableView))hy_didReloadDataHandler {
    objc_setAssociatedObject(self,
                             @selector(hy_didReloadDataHandler),
                             hy_didReloadDataHandler,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UITableView *tableView))hy_didReloadDataHandler {
    return objc_getAssociatedObject(self, _cmd);
}

- (UIView *)hy_emtyContainerView {
    
    UIView *emtyView = objc_getAssociatedObject(self, _cmd);
    if (!emtyView) {
        emtyView = UIView.new;
        emtyView.backgroundColor = self.backgroundColor;
        emtyView.frame = CGRectMake(self.contentInset.left, self.contentInset.top, self.bounds.size.width - self.contentInset.left - self.contentInset.right, self.bounds.size.height - self.contentInset.top - self.contentInset.bottom - self.adjustedContentInset.top - self.adjustedContentInset.bottom);
        emtyView.hidden = YES;
        [self addSubview:emtyView];
        [self bringSubviewToFront:emtyView];
        objc_setAssociatedObject(self, _cmd, emtyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return emtyView;
}

@end
