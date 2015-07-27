//
//  JQCollectionView.m
//  
//
//  Created by James on 15/7/18.
//
//

#import "JQCollectionView.h"
#import "JQIndicatorView.h"

@interface JQCollectionView ()<UICollectionViewDelegateFlowLayout>

@end

@implementation JQCollectionView

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //用Integer代替枚举
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
        JQIndicatorView *indicator = [[JQIndicatorView alloc] initWithType:indexPath.row tintColor:[self randomColor]];
        indicator.tag = 101 + indexPath.row;
        
        indicator.center = cell.contentView.center;
        [cell.contentView addSubview:indicator];
        [indicator startAnimating];
    
    
    
    // Configure the cell
    
    return cell;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(100, 100);
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    JQIndicatorView *indicator = (JQIndicatorView *)[[collectionView cellForItemAtIndexPath:indexPath] viewWithTag:101+indexPath.row];
    if (indicator.isAnimating == YES) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定停止么？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            if (indicator.isAnimating == YES) {
                [indicator stopAnimating];
            }
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        [indicator startAnimating];
    }
}

#pragma mark - Others

- (UIColor *)randomColor{
    CGFloat red = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

- (IBAction)changeColor:(UIBarButtonItem *)sender {
    [self.collectionView reloadData];
}
@end
