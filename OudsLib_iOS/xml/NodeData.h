//
//  NodeData.h
//  ObjCLib
//
//  Created by Zhongyu Zhang on 11-11-24.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

@interface NodeData : NSObject
{
    NodeData        *parent;
    NSMutableArray  *children;
    NSString        *key;
    NSString        *leafvalue;
}

@property (nonatomic, retain)   NodeData        *parent;
@property (nonatomic, retain)   NSMutableArray  *children;
@property (nonatomic, retain)   NSString        *key;
@property (nonatomic, retain)   NSString        *leafvalue;

@property (nonatomic, readonly) BOOL            isLeaf;
@property (nonatomic, readonly) BOOL            hasLeafValue;

@property (nonatomic, readonly) NSArray         *keys;
@property (nonatomic, readonly) NSArray         *allKeys;
@property (nonatomic, readonly) NSArray         *uniqKeys;
@property (nonatomic, readonly) NSArray         *uniqAllKeys;
@property (nonatomic, readonly) NSArray         *leaves;
@property (nonatomic, readonly) NSArray         *allLeaves;

@property (nonatomic, readonly) NSString        *dump;

+ (NodeData *) nodeData;

- (NSString *) dump;
- (void) teardown; // 清除所有节点

// Leaf Utils
- (BOOL) isLeaf; // 判断是否是叶子节点
- (BOOL) hasLeafValue; // 判断节点是否有值
- (NSArray *) leaves; // 返回节点的所有一级子节点值
- (NSArray *) allLeaves; // 返回节点的所有子节点的值

// Key Utils
- (NSArray *) keys; // 返回节点所有一级子节点名称
- (NSArray *) allKeys; // 返回节点所有子节点名称
- (NSArray *) uniqKeys; // 返回节点一级子节点名称，不重复
- (NSArray *) uniqAllKeys; // 返回节点子节点名称，不重复


// Search Utils
- (NodeData *) objectForKey: (NSString *) aKey; // 根据节点名称查询节点
- (NSString *) leafForKey: (NSString *) aKey; // 根据节点名称查询出节点的值
- (NSMutableArray *) objectsForKey: (NSString *) aKey; // 根据节点名称查询出所以满足条件的节点
- (NSMutableArray *) leavesForKey: (NSString *) aKey; // 根据节点名称查询出所以满足条件的节点的值
- (NodeData *) objectForKeys: (NSArray *) keys; // 根据节点名称路径查询出第一个满足条件的节点
- (NSString *) leafForKeys: (NSArray *) keys; // 根据节点名称路径查询出第一个满足条件的节点的值

// Convert Utils
- (NSMutableDictionary *) dictionaryForChildren;

@end
