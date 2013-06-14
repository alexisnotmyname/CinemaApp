//
//  MoviesNC.m
//  sureseats
//
//  Created by Martin on 5/27/13.
//  Copyright (c) 2013 Ripplewave. All rights reserved.
//

#import "MoviesVC.h"

@interface MoviesVC (){
    NSMutableString *tempText;
    NSMutableArray *arrayTitle;
    NSMutableArray *arrayTitle2;
    MBProgressHUD *HUD;
    NSString *workingElement;
    NSString *addres;
    int ctr;
}

@end

@implementation MoviesVC
@synthesize movieListTableView;

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Now Showing"];
    
//    NSString *plistFile = [[NSBundle mainBundle] pathForResource:@"MovieList" ofType:@"plist"]; //setting the path
//    NSDictionary *pListContent = [NSDictionary dictionaryWithContentsOfFile:plistFile];
//    movieList = [[NSArray alloc] initWithArray:[pListContent objectForKey:@"Movies"]];
//    tempText = [[NSMutableString alloc] init];
    
    arrayTitle = [[NSMutableArray alloc] init];
    arrayTitle2 = [[NSMutableArray alloc] init];

    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self fetchData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(trimMovies) name:@"Event" object:nil];

}

- (void)trimMovies{
    NSLog(@"tapos na");
    
}

- (void) fetchData{
    
    NSURL* url = [NSURL URLWithString:@"http://api.sureseats.com/index.asp?ACTION=NOWSHOWING"];
    NSURLRequest* urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    AFXMLRequestOperation* request = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:urlRequest
                                      
     success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
         NSLog(@"schedule XML SUCCESS PARSING response ");
         XMLParser.delegate = self;
         [XMLParser parse];
     } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
         if(error.code == -1016){
             NSLog(@"schedule  XML FAIL ATTEMPT PARSE ANYWAY asjdghfkjas");
             XMLParser.delegate = self;
             [XMLParser parse];
         }
         else{
             NSLog(@"schedule  XML FAIL ATTEMPT %@:%d",error.localizedDescription,error.code);

         }
     }];
    [request start];
}

#pragma mark - Parsing lifecycle

- (void)startTheParsingProcess:(NSData *)parserData
{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:parserData]; //parserData passed to NSXMLParser delegate which starts the parsing process
    
    [parser setDelegate:self];
    [parser parse]; // starts the event-driven parsing operation.
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    workingElement = elementName;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    if ([workingElement isEqualToString:@"id"])
    {
//        NSLog(@"%@", string);
    }
    if ([workingElement isEqualToString:@"movie_title"])
    {
//        addres = string;
//        addres = [addres stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//        addres = [addres stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
//        [arrayTitle addObject:addres];
        if( !tempText )
        {
            tempText = [[NSMutableString alloc] init];
        }
        [tempText appendString:string];
    }
}



- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
//    [arrayTitle removeObject:@""];
    NSLog(@"%@",tempText);
    
    [self.movieListTableView reloadData];
    
    NSArray *array= [tempText componentsSeparatedByString:@"\n"];
    
    for(int x=0;x<array.count;x++){
        NSString *resultedString=[array objectAtIndex:x];
        NSLog(@" resultedString IS - %@",resultedString);
        [arrayTitle addObject:resultedString];
    }
    NSLog(@"%i",[array count]);
    NSLog(@"%@", arrayTitle);
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"Event"
     object:self];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"Paser Error = %@", parseError);
    //TODO: Create Alert message error
}

#pragma mark -Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return arrayTitle.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [arrayTitle objectAtIndex:indexPath.row];
//    cell.textLabel.text = [[movieList objectAtIndex:indexPath.row] objectForKey:@"Title"];
    //cell.detailTextLabel.text = [[movieList objectAtIndex:indexPath.row] objectForKey:@"Description"];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"movieDetail"]){
        UITableViewCell *cell = (UITableViewCell *)sender;
        NSIndexPath *ip = [movieListTableView indexPathForCell:cell];
        
        MovieDetailsVC *vc = (MovieDetailsVC*)[segue destinationViewController];
        NSString *movieTitle = [[movieList objectAtIndex:ip.row] objectForKey:@"Title"];
        vc.movieTitle = movieTitle;
        vc.movieDescription = [[movieList objectAtIndex:ip.row] objectForKey:@"Description"];
        vc.movieTrailerUrl = [[movieList objectAtIndex:ip.row] objectForKey:@"Trailer"];
        [vc.navigationItem setTitle:movieTitle];
    }
}



@end
