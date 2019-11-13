//
//  UICollectionViewCell+HyExtension.m
//  HyCategories
//  https://github.com/hydreamit/HyCategories
//
//  Created by Hy on 2017/9/5.
//  Copyright © 2017 Hy. All rights reserved.
//

#import "UICollectionViewCell+HyExtension.h"
#import "UICollectionView+HyExtension.h"
#import "HyRunTimeMethods.h"


@interface UICollectionViewCell ()
@property (nonatomic,strong) NSIndexPath *hy_indexPath;
@end


@implementation UICollectionViewCell (HyExtension)

+ (instancetype)hy_cellWithCollectionView:(UICollectionView *)collectionView
                                indexPath:(NSIndexPath *)indexPath
                                 cellData:(id)cellData {
    
    UICollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self)
                                              forIndexPath:indexPath];
    cell.hy_indexPath = indexPath;
    cell.hy_cellData = cellData;
    return cell;
}

- (id)hy_sectionData {
    if (self.hy_collectionView) {
        return [self.hy_collectionView hy_sectionDataAtSection:self.hy_indexPath.section];
    }
    return nil;
}

- (id)hy_collectionViewData {
    if (self.hy_collectionView) {
        return self.hy_collectionView.hy_collectionViewData;
    }
    return nil;
}

- (UICollectionView *)hy_collectionView {
    if (!self.superview) {
        return nil;
    }
    UICollectionView *collectionView = ((UICollectionView *)self.superview);
    if ([collectionView isKindOfClass:UICollectionView.class]) {
        return collectionView;
    }
    return nil;
}

- (void)hy_reloadCellData {}

- (void)setHy_cellData:(id)hy_cellData {
    
    UITableView *table ;
    [table headerViewForSection:0];
    objc_setAssociatedObject(self,
                             @selector(hy_cellData),
                             hy_cellData,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)hy_cellData {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHy_indexPath:(NSIndexPath *)hy_indexPath {
    objc_setAssociatedObject(self,
                             @selector(hy_indexPath),
                             hy_indexPath,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSIndexPath *)hy_indexPath {
    return objc_getAssociatedObject(self, _cmd);
}

@end
