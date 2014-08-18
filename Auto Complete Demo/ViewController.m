//
//  ViewController.m
//  Auto Complete Demo
//
//  Created by Omer Gurarslan on 18/08/14.
//  Copyright (c) 2014 Lucid Bilg. Hiz. Ltd. Şti. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize aramaCubugu;
@synthesize kisiler;
@synthesize autocompleteKisileri;
@synthesize autocompleteTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //bu listeyi autocomplete eslesmelerini tutmak icin kullanacagiz.
    self.autocompleteKisileri = [[NSMutableArray alloc] init];
    
    //autocomplete bu liste ile eslesme arayacak.
    self.kisiler = [[NSMutableArray alloc] initWithObjects:
                    @"Safsata Nuri",
                    @"Deli Remzi",
                    @"Kel Niyazi",
                    @"Kevser Sozel", nil];
    
    //acilis esnasinda gorunmez olacak, sonuc eslestigi zaman gorunur olacak.
    autocompleteTableView.hidden = YES;
    
    //uygulama acildiginda arama cubugunun aktif olmasi icin:
    [self.aramaCubugu becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    //yeni arama oldugu icin listeyi temizle
    [autocompleteKisileri removeAllObjects];
    
    //substring metin icerigi ile baslayan kisiler listesi uyelerini
    //autocompleteKisileri listesine tasi.
    for(NSString *curString in kisiler) {
        NSRange substringRange = [curString rangeOfString:substring options:NSCaseInsensitiveSearch];
        if (substringRange.location == 0) {
            [autocompleteKisileri addObject:curString];
        }
    }
    
    //tabloyu guncellemek icin gerekli olan metodlari tetikle
    [autocompleteTableView reloadData];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    //aciliste gizli olan listeyi simdi gorunur hale getir:
    autocompleteTableView.hidden = NO;
    
    //arama cubugundaki yaziyi kisiler listesindeki deger ile tamamla
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring stringByReplacingCharactersInRange:range withString:string ];
    [self searchAutocompleteEntriesWithSubstring:substring];
    return YES;
}

//tablo eleman sayisi autocompleteKisileri listesi eleman sayisi kadar olmalidir:
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    return autocompleteKisileri.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    static NSString *AutoCompleteRowIdentifier = @"AutoCompleteSatirTanim";
    cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    cell.textLabel.text = [autocompleteKisileri objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    aramaCubugu.text = selectedCell.textLabel.text;
    
}

@end
