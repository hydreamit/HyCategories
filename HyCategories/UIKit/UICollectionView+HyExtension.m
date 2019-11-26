//
//   UICollectionView+HyExtension.m
//  HyCategories
//  https://github.com/hydreamit/HyCategories
//
//  Created by Hy on 17/6/9.
//  Copyright © 2017年 Hy. All rights reserved.
//

#import "UICollectionView+HyExtension.h"
#import "HyRunTimeMethods.h"

@interface HyCollectionViewDelegateConfigure ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic,copy) NSInteger(^numberOfSections)(UICollectionView *collectionView);
@property (nonatomic,copy) NSInteger(^numberOfItemsInSection)(UICollectionView *collectionView, NSInteger section);
// cell
@property (nonatomic,copy) UICollectionViewCell *(^cellForItemAtIndexPath)(UICollectionView *collectionView, NSIndexPath * indexPath);
@property (nonatomic,copy) CGFloat (^heightForRowAtIndexPath)(UICollectionView *collectionView, NSIndexPath * indexPath);
@property (nonatomic,copy) void (^didSelectItemAtIndexPath)(UICollectionView *collectionView, NSIndexPath * indexPath);
@property (nonatomic,copy) void (^willDisplayCell)(UICollectionView *collectionView,UICollectionViewCell *cell, NSIndexPath * indexPath);
@property (nonatomic,copy) UICollectionReusableView  *(^seactionHeaderFooterView)(UICollectionView *collectionView,NSString *kind, NSIndexPath * indexPath);
@property (nonatomic,copy) void (^willDisPlayHeaderFooterView)(UICollectionView *collectionView,UICollectionReusableView *view,NSString *kind, NSIndexPath * indexPath);

@property (nonatomic,copy) CGSize(^layoutSize)(UICollectionView *collectionView, UICollectionViewLayout *layout, NSIndexPath *indexPath);
@property (nonatomic,copy) UIEdgeInsets(^layoutInsets)(UICollectionView *collectionView, UICollectionViewLayout *layout, NSInteger section);
@property (nonatomic,copy) CGFloat(^layoutMinimumLineSpacing)(UICollectionView *collectionView, UICollectionViewLayout *layout, NSInteger section);
@property (nonatomic,copy) CGFloat(^layoutMinimumInteritemSpacing)(UICollectionView *collectionView, UICollectionViewLayout *layout, NSInteger section);
@property (nonatomic,copy) CGSize(^layoutReferenceSizeForHeader)(UICollectionView *collectionView, UICollectionViewLayout *layout, NSInteger section);
@property (nonatomic,copy) CGSize(^layoutReferenceSizeForFooter)(UICollectionView *collectionView, UICollectionViewLayout *layout, NSInteger section);

@property (nonatomic,copy) NSArray<NSString *> *(^sectionAndCellDataKey)(void);
@property (nonatomic,copy) Class(^cellClassForRow)(id cellData, NSIndexPath * indexPath);
@property (nonatomic,copy) void(^cellWithData)(UICollectionViewCell *cell, id cellData, NSIndexPath *indexPath);
@property (nonatomic,copy) Class(^sectionHeaderFooterViewClassAtSection)(id sectionData,HyCollectionSeactionViewKinds seactionViewKinds,NSUInteger section);
@property (nonatomic,copy) void(^sectionHeaderFooterViewWithSectionData)(UIView *headerFooterView,id sectionData,HyCollectionSeactionViewKinds seactionViewKinds,NSUInteger section);
@property (nonatomic,copy) void(^emtyViewBlock)(UICollectionView *,UIView *);

@property (nonatomic,weak) UICollectionView *collectionView;
@property (nonatomic,copy) NSString *cellDataKey;
@property (nonatomic,copy) NSString *sectionDataKey;
@property (nonatomic,strong) NSArray<Class> *cellClasses;
@property (nonatomic,strong) NSArray<Class> *headerViewClasses;
@property (nonatomic,strong) NSArray<Class> *footerViewClasses;
@end
@implementation HyCollectionViewDelegateConfigure
- (instancetype)configNumberOfSections:(NSInteger (^)(UICollectionView *collectionView))block {
    self.numberOfSections = [block copy];
    return self;
}
- (instancetype)configNumberOfItemsInSection:(NSInteger (^)(UICollectionView *collectionView, NSInteger section))block {
    self.numberOfItemsInSection = [block copy];
    return self;
}
// cell
- (instancetype)configCellForItemAtIndexPath:(UICollectionViewCell *(^)(UICollectionView *collectionView, NSIndexPath *indexPath))block {
    self.cellForItemAtIndexPath = [block copy];
    return self;
}
- (instancetype)configHeightForRowAtIndexPath:(CGFloat (^)(UICollectionView *collectionView, NSIndexPath *indexPath))block {
    self.heightForRowAtIndexPath = [block copy];
    return self;
}
- (instancetype)configDidSelectItemAtIndexPath:(void (^)(UITableView *tableView, NSIndexPath *indexPath))block {
    self.didSelectItemAtIndexPath = [block copy];
    return self;
}
- (instancetype)configWillDisplayCell:(void(^)(UICollectionView *collectionView,UICollectionViewCell *cell, NSIndexPath * indexPath))block {
    self.willDisplayCell = [block copy];
    return self;
}
// header footer
- (instancetype)configSeactionHeaderFooterViewAtIndexPath:(UICollectionReusableView *(^)(UICollectionView *collectionView,NSString *kind, NSIndexPath * indexPath))block {
    self.seactionHeaderFooterView = [block copy];
    return self;
}
- (instancetype)configWillDisPlayHeaderFooterViewAtIndexPath:(void (^)(UICollectionView *collectionView,UICollectionReusableView *view,NSString *kind, NSIndexPath * indexPath))block {
    self.willDisPlayHeaderFooterView = [block copy];
    return self;
}
- (instancetype)configLayoutSize:(CGSize (^)(UICollectionView *collectionView, UICollectionViewLayout *layout, NSIndexPath *indexPath))block {
    self.layoutSize = [block copy];
    return self;
}
- (instancetype)configLayoutInsets:(UIEdgeInsets (^)(UICollectionView *collectionView, UICollectionViewLayout *layout, NSInteger section))block {
    self.layoutInsets = [block copy];
    return self;
}
- (instancetype)configLayoutMinimumLineSpacing:(CGFloat (^)(UICollectionView *collectionView, UICollectionViewLayout *layout, NSInteger section))block {
    self.layoutMinimumLineSpacing = [block copy];
    return self;
}

- (instancetype)configLayoutMinimumInteritemSpacing:(CGFloat (^)(UICollectionView *collectionView, UICollectionViewLayout *layout, NSInteger section))block{
    self.layoutMinimumInteritemSpacing = [block copy];
    return self;
}
- (instancetype)configLayoutReferenceSizeForHeader:(CGSize (^)(UICollectionView *collectionView, UICollectionViewLayout *layout, NSInteger section))block {
    self.layoutReferenceSizeForHeader = [block copy];
    return self;
}
- (instancetype)configLayoutReferenceSizeForFooter:(CGSize (^)(UICollectionView *collectionView, UICollectionViewLayout *layout, NSInteger section))block {
    self.layoutReferenceSizeForFooter = [block copy];
    return self;
}

- (instancetype)configSectionAndCellDataKey:(NSArray<NSString *> *(^)(void))block {
    self.sectionAndCellDataKey = [block copy];
    return self;
}
- (instancetype)configCellClassForRow:(Class (^)(id cellData, NSIndexPath * indexPath))block {
    self.cellClassForRow = [block copy];
    return self;
}
- (instancetype)configCellWithData:(void (^)(UICollectionViewCell *cell, id cellData, NSIndexPath *indexPath))block {
    self.cellWithData = [block copy];
    return self;
}
- (instancetype)configSectionHeaderFooterViewClassAtSection:(Class (^)(id sectionData,
                                                                       HyCollectionSeactionViewKinds seactionViewKinds,
                                                                       NSUInteger section))block {
    self.sectionHeaderFooterViewClassAtSection = [block copy];
    return self;
}
- (instancetype)configSectionHeaderFooterViewWithSectionData:(void (^)(UIView *headerFooterView,
                                                                       id sectionData,
                                                                       HyCollectionSeactionViewKinds seactionViewKinds,
                                                                       NSUInteger section))block {
    self.sectionHeaderFooterViewWithSectionData = [block copy];
    return self;
}

- (instancetype)configEmtyView:(void(^)(UICollectionView *tableView, UIView *emtyContainerView))block {
    self.emtyViewBlock = [block copy];
    return self;
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return
    self.numberOfSections ?
    self.numberOfSections(collectionView) : [self getSectionCount];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    return
    self.numberOfItemsInSection ?
    self.numberOfItemsInSection(collectionView, section) : [self getCellCountInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (self.cellForItemAtIndexPath) {
        return self.cellForItemAtIndexPath(collectionView, indexPath);
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
        return
        cellClass ? [cellClass hy_cellWithCollectionView:collectionView
                                               indexPath:indexPath
                                                cellData:cellData] : nil;
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.willDisplayCell ?
    self.willDisplayCell(collectionView,cell, indexPath) : nil;
    
    self.cellWithData ?
    self.cellWithData(cell, [self getCellDataAtIndexPath:indexPath], indexPath) : nil;
    
    [cell hy_reloadCellData];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    if (self.seactionHeaderFooterView) {
        return self.seactionHeaderFooterView(collectionView, kind, indexPath);
    } else {
        
        HyCollectionSeactionViewKinds sectionKinds =
        [kind isEqualToString:UICollectionElementKindSectionHeader] ?
        HyCollectionSeactionViewKindsHeader : HyCollectionSeactionViewKindsFooter;
        
        id sectionData = [self getSectionDtaAtSection:indexPath.section];
        
        id secionHeaderFooterClass;
        if (self.sectionHeaderFooterViewClassAtSection) {
            secionHeaderFooterClass = self.sectionHeaderFooterViewClassAtSection(sectionData,sectionKinds, indexPath.section);
        } else {
            NSArray *array =
            sectionKinds == HyCollectionSeactionViewKindsHeader ?
            self.headerViewClasses : self.footerViewClasses;
            if (array.count == 1) {
                secionHeaderFooterClass = array.firstObject;
            };
        }
        
        if (class_isMetaClass(object_getClass(secionHeaderFooterClass))) {
            return 
            [secionHeaderFooterClass hy_headerFooterViewWithCollectionView:collectionView
                                                                 indexPath:indexPath
                                                         seactionViewKinds:sectionKinds
                                                               sectionData:sectionData];
        } else if ([secionHeaderFooterClass isKindOfClass:UICollectionReusableView.class]) {
            return secionHeaderFooterClass;
        } return nil;
    }
}

- (void)collectionView:(UICollectionView *)collectionView
willDisplaySupplementaryView:(UICollectionReusableView *)view
        forElementKind:(NSString *)elementKind
           atIndexPath:(NSIndexPath *)indexPath {
    
    self.willDisPlayHeaderFooterView ?
    self.willDisPlayHeaderFooterView(collectionView,view, elementKind, indexPath) : nil;
    
    HyCollectionSeactionViewKinds sectionKinds =
    [elementKind isEqualToString:UICollectionElementKindSectionHeader] ?
    HyCollectionSeactionViewKindsHeader : HyCollectionSeactionViewKindsFooter;
    
    self.sectionHeaderFooterViewWithSectionData ?
    self.sectionHeaderFooterViewWithSectionData(view,
                                                [self getSectionDtaAtSection:indexPath.section],
                                                sectionKinds,
                                                indexPath.section) : nil;
    
    [view hy_reloadHeaderFooterViewData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.didSelectItemAtIndexPath ?
    self.didSelectItemAtIndexPath(collectionView, indexPath) : nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize size = CGSizeZero;
    if ([collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.class]) {
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionViewLayout;
        size = layout.itemSize;
    }
    return
    self.layoutSize ?
    self.layoutSize(collectionView, collectionViewLayout, indexPath) : size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if ([collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.class]) {
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionViewLayout;
        insets = layout.sectionInset;
    }
    return
    self.layoutInsets ?
    self.layoutInsets(collectionView, collectionViewLayout, section) : insets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    CGFloat height = 0.0;
    if ([collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.class]) {
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionViewLayout;
        height = layout.minimumLineSpacing;
    }
    return
    self.layoutMinimumLineSpacing ?
    self.layoutMinimumLineSpacing(collectionView, collectionViewLayout, section) : height;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    CGFloat height = 0.0;
    if ([collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.class]) {
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionViewLayout;
        height = layout.minimumInteritemSpacing;
    }
    return
    self.layoutMinimumInteritemSpacing ?
    self.layoutMinimumInteritemSpacing(collectionView, collectionViewLayout, section) : height;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    CGSize size = CGSizeZero;
    if ([collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.class]) {
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionViewLayout;
        size = layout.headerReferenceSize;
    }
    return
    self.layoutReferenceSizeForHeader ?
    self.layoutReferenceSizeForHeader(collectionView, collectionViewLayout, section) : size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    CGSize size = CGSizeZero;
    if ([collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.class]) {
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionViewLayout;
        size = layout.headerReferenceSize;
    }
    return
    self.layoutReferenceSizeForFooter ?
    self.layoutReferenceSizeForFooter(collectionView, collectionViewLayout, section) : size;
}

- (NSInteger)getSectionCount {
    
    id sectionData = [self getSectionData];
    if ([self isArrayWithData:sectionData]) {
        return ((NSArray *)sectionData).count;
    }
    
    if ([self isArrayWithData:self.hy_collectionViewData] &&
        ![self getSectionKey].length && [self getCellKey].length) {
        return ((NSArray *)self.hy_collectionViewData).count;
    }
    
    return self.hy_collectionViewData ? 1 : 0;
}

- (NSInteger)getCellCountInSection:(NSInteger)section {
    
    id cellData = [self getCellKeyDataWithSection:section];
    if ([self isArrayWithData:cellData]) {
        return ((NSArray *)cellData).count;
    }
    
    if ([self isArrayWithData:self.hy_collectionViewData] &&
        ![self getSectionKey].length && ![self getCellKey].length) {
        return ((NSArray *)self.hy_collectionViewData).count;
    }
    
    return self.hy_collectionViewData ? 1 : 0;
}

- (id)getCellDataAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath) {
        return nil;
    }
    
    id cellData = [self getCellKeyDataWithSection:indexPath.section];
    if ([self isArrayWithData:cellData]) {
        if (((NSArray *)cellData).count > indexPath.row) {
            return ((NSArray *)cellData)[indexPath.row];
        }
    }
    
    if ([self isArrayWithData:self.hy_collectionViewData] &&
        ![self getSectionKey].length && ![self getCellKey].length) {
        if (((NSArray *)self.hy_collectionViewData).count > indexPath.row) {
            return ((NSArray *)self.hy_collectionViewData)[indexPath.row];
        }
    }
    
    return self.hy_collectionViewData;
}

- (id)getSectionDtaAtSection:(NSInteger)section {
    
    id sectionData = [self getSectionData];
    if ([self isArrayWithData:sectionData]) {
        if (((NSArray *)sectionData).count > section) {
            return ((NSArray *)sectionData)[section];
        }
    }
    
    if ([self isArrayWithData:self.hy_collectionViewData] &&
        ![self getSectionKey].length && [self getCellKey].length) {
        if (((NSArray *)self.hy_collectionViewData).count > section) {
            return ((NSArray *)self.hy_collectionViewData)[section];
        }
    }
    
    return self.hy_collectionViewData;
}

- (id)getSectionData {
    
    NSString *sectionKey = [self getSectionKey];
    if (sectionKey.length && sectionKey.length) {
        NSArray *keys = [sectionKey componentsSeparatedByString:@"."];
        id data = self.hy_collectionViewData;
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
    if (self.hy_collectionViewData && cellKey.length) {
        
        id sectionData = [self getSectionData] ?: self.hy_collectionViewData;
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


- (id)hy_collectionViewData {
    return self.collectionView.hy_collectionViewData;
}

@end


@interface UICollectionView ()
@property (nonatomic,strong) HyCollectionViewDelegateConfigure *hy_delegateConfigure;
@property (nonatomic,strong) UIView *hy_emtyContainerView;
@end
@implementation UICollectionView (HyExtension)

+ (instancetype)hy_collectionViewWithFrame:(CGRect)frame
                                    layout:(UICollectionViewLayout *)layout
                               cellClasses:(NSArray<Class> *)cellClasses
                         headerViewClasses:(NSArray<Class> *)headerViewClasses
                         footerViewClasses:(NSArray<Class> *)footerViewClasses
                                dataSource:(id<UICollectionViewDataSource>)dataSource
                                  delegate:(id<UICollectionViewDelegate>)delegate {
    
    UICollectionView *colletionView = [[self alloc] initWithFrame:frame collectionViewLayout:layout];
    colletionView.backgroundColor = UIColor.whiteColor;
    if (@available(iOS 10.0, *)) {
        colletionView.prefetchingEnabled = NO;
    }
    if (@available(iOS 11.0, *)) {
        colletionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [colletionView hy_registerCellWithCellClasses:cellClasses];
    [colletionView hy_registerHeaderWithViewClasses:headerViewClasses];
    [colletionView hy_registerFooterWithViewClasses:footerViewClasses];
    colletionView.dataSource = dataSource;
    colletionView.delegate = delegate;
    return colletionView;
}

+ (instancetype)hy_collectionViewWithFrame:(CGRect)frame
                                    layout:(UICollectionViewLayout *)layout
                        collectionViewData:(id)collectionViewData
                               cellClasses:(NSArray<Class> *)cellClasses
                         headerViewClasses:(NSArray<Class> *)headerViewClasses
                         footerViewClasses:(NSArray<Class> *)footerViewClasses
                         delegateConfigure:(void (^)(HyCollectionViewDelegateConfigure *configure))delegateConfigure {
    
    UICollectionView *colletionView = [[self alloc] initWithFrame:frame collectionViewLayout:layout];
    colletionView.backgroundColor = UIColor.whiteColor;
    if (@available(iOS 10.0, *)) {
        colletionView.prefetchingEnabled = NO;
    }
    if (@available(iOS 11.0, *)) {
        colletionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    colletionView.hy_collectionViewData = collectionViewData;
    [colletionView hy_registerCellWithCellClasses:cellClasses];
    [colletionView hy_registerHeaderWithViewClasses:headerViewClasses];
    [colletionView hy_registerFooterWithViewClasses:footerViewClasses];
    colletionView.hy_delegateConfigure = [[HyCollectionViewDelegateConfigure alloc] init];
    !delegateConfigure ?: delegateConfigure(colletionView.hy_delegateConfigure);
    colletionView.hy_delegateConfigure.collectionView = colletionView;
    colletionView.hy_delegateConfigure.cellClasses = cellClasses;
    colletionView.hy_delegateConfigure.headerViewClasses = headerViewClasses;
    colletionView.hy_delegateConfigure.footerViewClasses = footerViewClasses;
    colletionView.dataSource = colletionView.hy_delegateConfigure;
    colletionView.delegate = colletionView.hy_delegateConfigure;
    return colletionView;
}

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

- (void)hy_clearSelectedItemsAnimated:(BOOL)animated {
    NSArray *selectedItemIndexPaths = [self indexPathsForSelectedItems];
    for (NSIndexPath *indexPath in selectedItemIndexPaths) {
        [self deselectItemAtIndexPath:indexPath animated:animated];
    }
}

- (BOOL)hy_cellIsVisibleAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *visibleItemIndexPaths = self.indexPathsForVisibleItems;
    for (NSIndexPath *visibleIndexPath in visibleItemIndexPaths) {
        if ([indexPath isEqual:visibleIndexPath]) {
            return YES;
        }
    }
    return NO;
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
            self.hy_delegateConfigure.numberOfItemsInSection ?
            self.hy_delegateConfigure.numberOfItemsInSection(self, 0) :
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
        [self registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass)
                                         bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
    } else {
        [self registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
    }
}

- (void)hy_registerHeaderWithViewClasses:(NSArray<Class> *)viewClasses {
    
    if (!viewClasses.count) { return; }
    [viewClasses enumerateObjectsUsingBlock:^(Class obj,
                                              NSUInteger idx,
                                              BOOL *stop) {
        [self hy_registerHeaderWithViewClass:obj];
    }];
}
- (void)hy_registerHeaderWithViewClass:(Class)viewClass {
    
    if (!viewClass) { return; }
    
    NSString *viewClassString = NSStringFromClass(viewClass);
    NSString *nibPath =  [[NSBundle mainBundle] pathForResource:viewClassString ofType:@"nib"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:nibPath]) {
        [self hy_registerHeaderFooterViewIsNib:YES
                                      isHeader:NO
                                     viewClass:viewClass];
    } else {
        [self hy_registerHeaderFooterViewIsNib:NO
                                      isHeader:NO
                                     viewClass:viewClass];
    }
}

- (void)hy_registerFooterWithViewClasses:(NSArray<Class> *)viewClasses {
    
    if (!viewClasses.count) { return; }
    [viewClasses enumerateObjectsUsingBlock:^(Class obj,
                                              NSUInteger idx,
                                              BOOL *stop) {
        [self hy_registerFooterWithViewClass:obj];
    }];
}
- (void)hy_registerFooterWithViewClass:(Class)viewClass {
    
    if (!viewClass) { return; }
    
    NSString *viewClassString = NSStringFromClass(viewClass);
    NSString *nibPath =  [[NSBundle mainBundle] pathForResource:viewClassString ofType:@"nib"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:nibPath]) {
        [self hy_registerHeaderFooterViewIsNib:YES
                                      isHeader:YES
                                     viewClass:viewClass];
    } else {
        [self hy_registerHeaderFooterViewIsNib:NO
                                      isHeader:YES
                                     viewClass:viewClass];
    }
}

- (void)hy_registerHeaderFooterViewIsNib:(BOOL)isNib
                                isHeader:(BOOL)isHeader
                               viewClass:(Class)viewClass {
    
    NSString *ofKind = isHeader ? UICollectionElementKindSectionHeader :
    UICollectionElementKindSectionFooter;
    if (isNib) {
        [self registerNib:[UINib nibWithNibName:NSStringFromClass(viewClass)
                                         bundle:nil] forSupplementaryViewOfKind:ofKind withReuseIdentifier:NSStringFromClass(viewClass)];
    } else {
        [self registerClass:viewClass forSupplementaryViewOfKind:ofKind withReuseIdentifier:NSStringFromClass(viewClass)];
    }
}

- (void)setHy_delegateConfigure:(HyCollectionViewDelegateConfigure *)hy_delegateConfigure {
    
    objc_setAssociatedObject(self,
                             @selector(hy_delegateConfigure),
                             hy_delegateConfigure,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (HyCollectionViewDelegateConfigure *)hy_delegateConfigure {
    return objc_getAssociatedObject(self, _cmd);
}


- (void)setHy_collectionViewData:(id)hy_collectionViewData {
    objc_setAssociatedObject(self,
                             @selector(hy_collectionViewData),
                             hy_collectionViewData,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)hy_collectionViewData {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHy_willReloadDataAsynHandler:(void (^)(UICollectionView *collectionView))hy_willReloadDataAsynHandler {
    objc_setAssociatedObject(self,
                             @selector(hy_willReloadDataAsynHandler),
                             hy_willReloadDataAsynHandler,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UICollectionView *collectionView))hy_willReloadDataAsynHandler {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHy_willReloadDataHandler:(void (^)(UICollectionView *collectionView))hy_willReloadDataHandler {
    objc_setAssociatedObject(self,
                             @selector(hy_willReloadDataHandler),
                             hy_willReloadDataHandler,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UICollectionView *collectionView))hy_willReloadDataHandler {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHy_didReloadDataHandler:(void (^)(UICollectionView *collectionView))hy_didReloadDataHandler {
    objc_setAssociatedObject(self,
                             @selector(hy_didReloadDataHandler),
                             hy_didReloadDataHandler,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UICollectionView *collectionView))hy_didReloadDataHandler {
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
