//
//  XMLParser.m
//  ObjCLib
//
//  Created by Zhongyu Zhang on 11-11-24.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "XMLParser.h"

@implementation XMLParser

static XMLParser *sharedInstance = nil;

// Use just one parser instance at any time
+ (XMLParser *) sharedInstance
{
    if(!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

// Parser returns the tree root. You may have to go down one node to the real results
- (NodeData *) parse: (NSXMLParser *) parser
{
    stack = [NSMutableArray array];
    
    NodeData *root = [NodeData nodeData];
    root.parent = nil;
    root.leafvalue = nil;
    root.children = [NSMutableArray array];
    
    [stack addObject:root];
    
    [parser setDelegate:self];
    [parser parse];
    [parser release];
    
    // pop down to real root
    NodeData *realroot = [[root children] lastObject];
    root.children = nil;
    root.parent = nil;
    root.leafvalue = nil;
    root.key = nil;
    
    realroot.parent = nil;
    return realroot;
}


- (NodeData *)parseXMLFromURL: (NSURL *) url
{  
    NodeData *results;
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    results = [self parse:parser];
    [pool drain];
    return results;
}

- (NodeData *)parseXMLFromData: (NSData *) data
{  
    NodeData *results;
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    results = [self parse:parser];
    [pool drain];
    return results;
}


// 当解析器对象遇到xml的开始标记时，调用这个方法
// Descend to a new element
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) elementName = qName;
    
    NodeData *leaf = [NodeData nodeData];
    leaf.parent = [stack lastObject];
    [(NSMutableArray *)[[stack lastObject] children] addObject:leaf];
    
    leaf.key = [NSString stringWithString:elementName];
    leaf.leafvalue = nil;
    leaf.children = [NSMutableArray array];
    
    [stack addObject:leaf];
}

// 当解析器对象遇到xml的结束标记时，调用这个方法
// Pop after finishing element
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    [stack removeLastObject];
}

// 当解析器找到开始标记和结束标记之间的字符时，调用这个方法
// Reached a leaf
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (![[stack lastObject] leafvalue])
    {
        [[stack lastObject] setLeafvalue:[NSString stringWithString:string]];
        return;
    }
    [[stack lastObject] setLeafvalue:[NSString stringWithFormat:@"%@%@", [[stack lastObject] leafvalue], string]];
}

@end

