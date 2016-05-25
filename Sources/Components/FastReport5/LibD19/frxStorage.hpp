// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxStorage.pas' rev: 26.00 (Windows)

#ifndef FrxstorageHPP
#define FrxstorageHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxstorage
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS ENotImplemented;
#pragma pack(push,4)
class PASCALIMPLEMENTATION ENotImplemented : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ENotImplemented(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ENotImplemented(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : System::Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall ENotImplemented(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ENotImplemented(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ENotImplemented(NativeUInt Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateResFmt */ inline __fastcall ENotImplemented(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall ENotImplemented(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ENotImplemented(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ENotImplemented(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ENotImplemented(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ENotImplemented(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ENotImplemented(NativeUInt Ident, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ENotImplemented(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS ENotSupportedException;
#pragma pack(push,4)
class PASCALIMPLEMENTATION ENotSupportedException : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ENotSupportedException(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ENotSupportedException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : System::Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall ENotSupportedException(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ENotSupportedException(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ENotSupportedException(NativeUInt Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateResFmt */ inline __fastcall ENotSupportedException(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall ENotSupportedException(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ENotSupportedException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ENotSupportedException(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ENotSupportedException(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ENotSupportedException(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ENotSupportedException(NativeUInt Ident, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ENotSupportedException(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TProxyStream;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TProxyStream : public System::Classes::TStream
{
	typedef System::Classes::TStream inherited;
	
private:
	System::Classes::TStream* FStream;
	int FOffset;
	int FPos;
	int FSize;
	void __fastcall Init(System::Classes::TStream* Stream, int Offset, int Size);
	bool __fastcall AdjustRange(int &Len);
	
public:
	__fastcall TProxyStream(System::Classes::TStream* Stream, int Offset, int Size);
	virtual int __fastcall Read(void *Buffer, int Count)/* overload */;
	virtual int __fastcall Write(const void *Buffer, int Count)/* overload */;
	virtual int __fastcall Seek(int Offset, System::Word Origin)/* overload */;
	__property int Offset = {read=FOffset, nodefault};
	__property System::Classes::TStream* BaseStream = {read=FStream};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TProxyStream(void) { }
	
/* Hoisted overloads: */
	
public:
	inline int __fastcall  Read(System::DynamicArray<System::Byte> Buffer, int Offset, int Count){ return System::Classes::TStream::Read(Buffer, Offset, Count); }
	inline int __fastcall  Read(System::DynamicArray<System::Byte> &Buffer, int Count){ return System::Classes::TStream::Read(Buffer, Count); }
	inline int __fastcall  Write(const System::DynamicArray<System::Byte> Buffer, int Offset, int Count){ return System::Classes::TStream::Write(Buffer, Offset, Count); }
	inline int __fastcall  Write(const System::DynamicArray<System::Byte> Buffer, int Count){ return System::Classes::TStream::Write(Buffer, Count); }
	inline __int64 __fastcall  Seek(const __int64 Offset, System::Classes::TSeekOrigin Origin){ return System::Classes::TStream::Seek(Offset, Origin); }
	inline __int64 __fastcall  Seek _DEPRECATED_ATTRIBUTE0 (const __int64 Offset, System::Word Origin){ return System::Classes::TStream::Seek(Offset, Origin); }
	
};

#pragma pack(pop)

class DELPHICLASS TFmtStream;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TFmtStream : public System::Classes::TStream
{
	typedef System::Classes::TStream inherited;
	
private:
	System::Classes::TStream* FOutput;
	bool FOwn;
	bool FFormatted;
	int FIndent;
	
public:
	__fastcall TFmtStream(System::Classes::TStream* Output, bool Own);
	__fastcall virtual ~TFmtStream(void);
	virtual int __fastcall Read(void *Buffer, int Count)/* overload */;
	virtual int __fastcall Write(const void *Buffer, int Count)/* overload */;
	void __fastcall PutsRawA(const System::AnsiString s)/* overload */;
	void __fastcall PutsRaw(const System::UnicodeString s)/* overload */;
	void __fastcall PutsRawA(const System::AnsiString Fmt, System::TVarRec const *Args, const int Args_Size)/* overload */;
	void __fastcall PutsRaw(const System::UnicodeString Fmt, System::TVarRec const *Args, const int Args_Size)/* overload */;
	void __fastcall PutsA(const System::AnsiString s)/* overload */;
	void __fastcall Puts(const System::UnicodeString s = System::UnicodeString())/* overload */;
	void __fastcall PutsA(const System::AnsiString Fmt, System::TVarRec const *Args, const int Args_Size)/* overload */;
	void __fastcall Puts(const System::UnicodeString Fmt, System::TVarRec const *Args, const int Args_Size)/* overload */;
	void __fastcall IncIndent(int Step);
	__property bool Formatted = {read=FFormatted, write=FFormatted, nodefault};
	__property int Indent = {read=FIndent, write=FIndent, nodefault};
/* Hoisted overloads: */
	
public:
	inline int __fastcall  Read(System::DynamicArray<System::Byte> Buffer, int Offset, int Count){ return System::Classes::TStream::Read(Buffer, Offset, Count); }
	inline int __fastcall  Read(System::DynamicArray<System::Byte> &Buffer, int Count){ return System::Classes::TStream::Read(Buffer, Count); }
	inline int __fastcall  Write(const System::DynamicArray<System::Byte> Buffer, int Offset, int Count){ return System::Classes::TStream::Write(Buffer, Offset, Count); }
	inline int __fastcall  Write(const System::DynamicArray<System::Byte> Buffer, int Count){ return System::Classes::TStream::Write(Buffer, Count); }
	
};

#pragma pack(pop)

class DELPHICLASS TObjList;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TObjList : public System::Classes::TList
{
	typedef System::Classes::TList inherited;
	
public:
	virtual void __fastcall Clear(void);
public:
	/* TList.Destroy */ inline __fastcall virtual ~TObjList(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TObjList(void) : System::Classes::TList() { }
	
};

#pragma pack(pop)

class DELPHICLASS TBase64Encoder;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TBase64Encoder : public System::Classes::TStream
{
	typedef System::Classes::TStream inherited;
	
private:
	System::Classes::TStream* FOutput;
	int FCache;
	int FUsed;
	System::StaticArray<System::Byte, 64> FMap;
	
protected:
	void __fastcall InitMap(void);
	void __fastcall Encode(int a, int n);
	void __fastcall Finalise(void);
	
public:
	__fastcall TBase64Encoder(System::Classes::TStream* Output);
	__fastcall virtual ~TBase64Encoder(void);
	virtual int __fastcall Read(void *Buffer, int Count)/* overload */;
	virtual int __fastcall Write(const void *Buffer, int Count)/* overload */;
	TBase64Encoder* __fastcall This(void);
/* Hoisted overloads: */
	
public:
	inline int __fastcall  Read(System::DynamicArray<System::Byte> Buffer, int Offset, int Count){ return System::Classes::TStream::Read(Buffer, Offset, Count); }
	inline int __fastcall  Read(System::DynamicArray<System::Byte> &Buffer, int Count){ return System::Classes::TStream::Read(Buffer, Count); }
	inline int __fastcall  Write(const System::DynamicArray<System::Byte> Buffer, int Offset, int Count){ return System::Classes::TStream::Write(Buffer, Offset, Count); }
	inline int __fastcall  Write(const System::DynamicArray<System::Byte> Buffer, int Count){ return System::Classes::TStream::Write(Buffer, Count); }
	
};

#pragma pack(pop)

class DELPHICLASS THexEncoder;
#pragma pack(push,4)
class PASCALIMPLEMENTATION THexEncoder : public System::Classes::TStream
{
	typedef System::Classes::TStream inherited;
	
private:
	System::Classes::TStream* FOutput;
	
public:
	__fastcall THexEncoder(System::Classes::TStream* Output);
	virtual int __fastcall Read(void *Buffer, int Count)/* overload */;
	virtual int __fastcall Write(const void *Buffer, int Count)/* overload */;
public:
	/* TObject.Destroy */ inline __fastcall virtual ~THexEncoder(void) { }
	
/* Hoisted overloads: */
	
public:
	inline int __fastcall  Read(System::DynamicArray<System::Byte> Buffer, int Offset, int Count){ return System::Classes::TStream::Read(Buffer, Offset, Count); }
	inline int __fastcall  Read(System::DynamicArray<System::Byte> &Buffer, int Count){ return System::Classes::TStream::Read(Buffer, Count); }
	inline int __fastcall  Write(const System::DynamicArray<System::Byte> Buffer, int Offset, int Count){ return System::Classes::TStream::Write(Buffer, Offset, Count); }
	inline int __fastcall  Write(const System::DynamicArray<System::Byte> Buffer, int Count){ return System::Classes::TStream::Write(Buffer, Count); }
	
};

#pragma pack(pop)

class DELPHICLASS TLineSplitter;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLineSplitter : public System::Classes::TStream
{
	typedef System::Classes::TStream inherited;
	
private:
	System::AnsiString FSep;
	System::Classes::TStream* FOutput;
	int FLength;
	int FWritten;
	
public:
	__fastcall TLineSplitter(System::Classes::TStream* Output, int Length, System::AnsiString Sep);
	virtual int __fastcall Read(void *Buffer, int Count)/* overload */;
	virtual int __fastcall Write(const void *Buffer, int Count)/* overload */;
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLineSplitter(void) { }
	
/* Hoisted overloads: */
	
public:
	inline int __fastcall  Read(System::DynamicArray<System::Byte> Buffer, int Offset, int Count){ return System::Classes::TStream::Read(Buffer, Offset, Count); }
	inline int __fastcall  Read(System::DynamicArray<System::Byte> &Buffer, int Count){ return System::Classes::TStream::Read(Buffer, Count); }
	inline int __fastcall  Write(const System::DynamicArray<System::Byte> Buffer, int Offset, int Count){ return System::Classes::TStream::Write(Buffer, Offset, Count); }
	inline int __fastcall  Write(const System::DynamicArray<System::Byte> Buffer, int Count){ return System::Classes::TStream::Write(Buffer, Count); }
	
};

#pragma pack(pop)

class DELPHICLASS TBlockStream;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TBlockStream : public System::Classes::TMemoryStream
{
	typedef System::Classes::TMemoryStream inherited;
	
private:
	int FBlockShift;
	int __fastcall GetBlocksCount(void);
	void * __fastcall GetBlockData(int i);
	int __fastcall GetBlockSize(int i);
	int __fastcall GetCurrentBlock(void);
	
public:
	__fastcall TBlockStream(int BlockSizeShift);
	void * __fastcall Imm(int Value, int Count);
	void __fastcall Fill(System::Byte Value, int Count);
	void __fastcall EndBlock(System::Byte Value);
	__property int BlocksCount = {read=GetBlocksCount, nodefault};
	__property void * BlockData[int i] = {read=GetBlockData};
	__property int BlockSize[int i] = {read=GetBlockSize};
	__property int CurrentBlock = {read=GetCurrentBlock, nodefault};
	__property int BlockShift = {read=FBlockShift, nodefault};
public:
	/* TMemoryStream.Destroy */ inline __fastcall virtual ~TBlockStream(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TCachedStream;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TCachedStream : public System::Classes::TStream
{
	typedef System::Classes::TStream inherited;
	
private:
	typedef System::DynamicArray<System::Byte> _TCachedStream__1;
	
	
private:
	System::Classes::TStream* FStream;
	bool FDeleteOnDestroy;
	_TCachedStream__1 FChunk;
	int FUsed;
	int __fastcall GetCacheSize(void);
	void __fastcall SetCacheSize(int Size);
	
protected:
	void __fastcall FlushCache(void);
	
public:
	__fastcall TCachedStream(System::Classes::TStream* Stream, bool DeleteOnDestroy);
	__fastcall virtual ~TCachedStream(void);
	__property int CacheSize = {read=GetCacheSize, write=SetCacheSize, nodefault};
	virtual int __fastcall Read(void *Buffer, int Count)/* overload */;
	virtual int __fastcall Write(const void *Buffer, int Count)/* overload */;
	virtual int __fastcall Seek(int Offset, System::Word Origin)/* overload */;
/* Hoisted overloads: */
	
public:
	inline int __fastcall  Read(System::DynamicArray<System::Byte> Buffer, int Offset, int Count){ return System::Classes::TStream::Read(Buffer, Offset, Count); }
	inline int __fastcall  Read(System::DynamicArray<System::Byte> &Buffer, int Count){ return System::Classes::TStream::Read(Buffer, Count); }
	inline int __fastcall  Write(const System::DynamicArray<System::Byte> Buffer, int Offset, int Count){ return System::Classes::TStream::Write(Buffer, Offset, Count); }
	inline int __fastcall  Write(const System::DynamicArray<System::Byte> Buffer, int Count){ return System::Classes::TStream::Write(Buffer, Count); }
	inline __int64 __fastcall  Seek(const __int64 Offset, System::Classes::TSeekOrigin Origin){ return System::Classes::TStream::Seek(Offset, Origin); }
	inline __int64 __fastcall  Seek _DEPRECATED_ATTRIBUTE0 (const __int64 Offset, System::Word Origin){ return System::Classes::TStream::Seek(Offset, Origin); }
	
};

#pragma pack(pop)

class DELPHICLASS TMap;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TMap : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	void * operator[](void * Key) { return Items[Key]; }
	
protected:
	virtual void __fastcall SetItemExistence(void * Key, bool b) = 0 ;
	virtual bool __fastcall ItemExists(void * Key) = 0 ;
	virtual void * __fastcall GetItem(void * Key) = 0 ;
	virtual void __fastcall SetItem(void * Key, void * Value) = 0 ;
	
public:
	__property bool Exists[void * Key] = {read=ItemExists, write=SetItemExistence};
	__property void * Items[void * Key] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TObject.Create */ inline __fastcall TMap(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TMap(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TOrderedMap;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TOrderedMap : public TMap
{
	typedef TMap inherited;
	
public:
	virtual void __fastcall GetKeysAndValues(System::Classes::TList* Keys, System::Classes::TList* Values) = 0 ;
public:
	/* TObject.Create */ inline __fastcall TOrderedMap(void) : TMap() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TOrderedMap(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TBTree;
class DELPHICLASS TBTreeNode;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TBTree : public TOrderedMap
{
	typedef TOrderedMap inherited;
	
private:
	int FOrder;
	TBTreeNode* FRoot;
	TBTreeNode* __fastcall CreateNode(TBTreeNode* LNode = (TBTreeNode*)(0x0));
	bool __fastcall IsFull(TBTreeNode* Node);
	void __fastcall InsertKey(TBTreeNode* Node, int i, void * Key, void * Value, TBTreeNode* LNode, TBTreeNode* RNode);
	void __fastcall SplitTree(TBTreeNode* Node, int i);
	int __fastcall FindIndex(TBTreeNode* Node, void * Key);
	TBTreeNode* __fastcall FindKey(void * Key, /* out */ int &KeyIndex);
	int __fastcall GetHeight(void);
	int __fastcall GetKeysCount(void);
	
protected:
	bool __fastcall Insert(void * Key, void * Value);
	virtual bool __fastcall ItemExists(void * Key);
	virtual void * __fastcall GetItem(void * Key);
	virtual void __fastcall SetItem(void * Key, void * Value);
	virtual void __fastcall SetItemExistence(void * Key, bool b);
	__property TBTreeNode* Root = {read=FRoot};
	__property int Height = {read=GetHeight, nodefault};
	__property int KeysCount = {read=GetKeysCount, nodefault};
	__property int Order = {read=FOrder, nodefault};
	
public:
	__fastcall TBTree(int Order);
	__fastcall virtual ~TBTree(void);
	virtual void __fastcall GetKeysAndValues(System::Classes::TList* Keys, System::Classes::TList* Values);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TBTreeNode : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	typedef System::DynamicArray<void *> _TBTreeNode__1;
	
	typedef System::DynamicArray<TBTreeNode*> _TBTreeNode__2;
	
	typedef System::DynamicArray<void *> _TBTreeNode__3;
	
	
private:
	int FLen;
	_TBTreeNode__1 FKeys;
	_TBTreeNode__2 FRefs;
	_TBTreeNode__3 FVals;
	void __fastcall SetLen(int n);
	void * __fastcall GetKey(int i);
	TBTreeNode* __fastcall GetRef(int i);
	void * __fastcall GetVal(int i);
	void __fastcall SetKey(int i, void * k);
	void __fastcall SetRef(int i, TBTreeNode* r);
	void __fastcall SetVal(int i, void * v);
	
public:
	__fastcall TBTreeNode(int MaxLen);
	__property int Len = {read=FLen, write=SetLen, nodefault};
	__property void * Keys[int i] = {read=GetKey, write=SetKey};
	__property TBTreeNode* Refs[int i] = {read=GetRef, write=SetRef};
	__property void * Vals[int i] = {read=GetVal, write=SetVal};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TBTreeNode(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TAVLTree;
class DELPHICLASS TAVLTreeNode;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TAVLTree : public TMap
{
	typedef TMap inherited;
	
private:
	TAVLTreeNode* FRoot;
	bool __fastcall FindKey(void * Key, /* out */ TAVLTreeNode* &Node);
	void __fastcall Insert(TAVLTreeNode* Parent, TAVLTreeNode* Node, void * Key, void * Value);
	void __fastcall LiftChild(TAVLTreeNode* R, TAVLTreeNode* N, bool Leaf);
	
protected:
	virtual void __fastcall SetItemExistence(void * Key, bool b);
	virtual bool __fastcall ItemExists(void * Key);
	virtual void * __fastcall GetItem(void * Key);
	virtual void __fastcall SetItem(void * Key, void * Value);
	__property TAVLTreeNode* Root = {read=FRoot};
	
public:
	__fastcall virtual ~TAVLTree(void);
public:
	/* TObject.Create */ inline __fastcall TAVLTree(void) : TMap() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TAVLTreeNode : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TAVLTreeNode* operator[](bool Leaf) { return Child[Leaf]; }
	
private:
	void *FKey;
	void *FValue;
	System::Byte FHeight;
	System::StaticArray<TAVLTreeNode*, 2> FLeafs;
	TAVLTreeNode* __fastcall GetChild(bool Leaf);
	void __fastcall SetChild(bool Leaf, TAVLTreeNode* Node);
	System::Byte __fastcall GetHeight(void);
	
public:
	__fastcall TAVLTreeNode(void * Key, void * Value);
	__fastcall virtual ~TAVLTreeNode(void);
	void __fastcall UpdateHeight(void);
	__property void * Key = {read=FKey};
	__property void * Value = {read=FValue, write=FValue};
	__property System::Byte Height = {read=GetHeight, write=FHeight, nodefault};
	__property TAVLTreeNode* Child[bool Leaf] = {read=GetChild, write=SetChild/*, default*/};
};

#pragma pack(pop)

class DELPHICLASS THashTable;
#pragma pack(push,4)
class PASCALIMPLEMENTATION THashTable : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	void * operator[](int Key) { return Items[Key]; }
	
protected:
	void __fastcall SetValueInternal(int Key, void * Value);
	
public:
	virtual void * __fastcall GetValue(int Key) = 0 ;
	virtual void * __fastcall SetValue(int Key, void * Value) = 0 ;
	bool __fastcall SelfTest(int RS, int n);
	__property void * Items[int Key] = {read=GetValue, write=SetValueInternal/*, default*/};
public:
	/* TObject.Create */ inline __fastcall THashTable(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~THashTable(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,1)
struct DECLSPEC_DRECORD TLhtEntry
{
public:
	void *Next;
	int Key;
	void *Data;
};
#pragma pack(pop)


typedef TLhtEntry *PLhtEntry;

class DELPHICLASS TListHashTable;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TListHashTable : public THashTable
{
	typedef THashTable inherited;
	
private:
	void *FBushes;
	NativeUInt FHeap;
	PLhtEntry __fastcall CreateEntry(int Key);
	
public:
	virtual void * __fastcall GetValue(int Key);
	virtual void * __fastcall SetValue(int Key, void * Value);
	__fastcall TListHashTable(void);
	__fastcall virtual ~TListHashTable(void);
};

#pragma pack(pop)

typedef void __fastcall (*TLcWriteObj)(System::Classes::TStream* Stream, System::TObject* Obj);

typedef System::TObject* __fastcall (*TLcReadObj)(System::Classes::TStream* Stream);

struct DECLSPEC_DRECORD TLcObject
{
public:
	__int64 Offset;
	__int64 Size;
};


struct DECLSPEC_DRECORD TLcCreateParams
{
public:
	System::Classes::TStream* CacheStream;
	System::Classes::TStream* ObjectsStream;
	int QueueSize;
};


struct DECLSPEC_DRECORD TLcLoadedObject
{
public:
	System::TObject* Reference;
	int Index;
};


class DELPHICLASS TListCache;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TListCache : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	typedef System::DynamicArray<TLcLoadedObject> _TListCache__1;
	
	
public:
	System::TObject* operator[](int Index) { return Objects[Index]; }
	
private:
	TObjList* FObjects;
	System::Classes::TStream* FCacheStream;
	System::Classes::TStream* FObjectsStream;
	_TListCache__1 FCacheQueue;
	bool FUpdate;
	bool FProtect;
	bool FStaticSize;
	System::UnicodeString FCacheFile;
	System::UnicodeString FObjFile;
	
protected:
	bool __fastcall IsCaching(void);
	void __fastcall ClearQueue(void);
	System::TObject* __fastcall GetObject(int Index);
	void __fastcall SetObject(int Index, System::TObject* Obj);
	void __fastcall PushObject(System::TObject* Obj, int Index);
	void __fastcall UnloadObject(System::TObject* Obj, int Index);
	int __fastcall GetObjectsCount(void);
	void __fastcall SetObjectsCount(int NewCount);
	void __fastcall Initialize(const TLcCreateParams &Params);
	
public:
	TLcWriteObj WriteObj;
	TLcReadObj ReadObj;
	__fastcall TListCache(void)/* overload */;
	__fastcall TListCache(const TLcCreateParams &Params)/* overload */;
	__fastcall TListCache(System::UnicodeString CacheFile, System::UnicodeString ObjFile, int QueueSize)/* overload */;
	__fastcall virtual ~TListCache(void);
	void __fastcall Clear(void);
	void __fastcall Exchange(int Index1, int Index2);
	System::TObject* __fastcall First(void);
	System::TObject* __fastcall Last(void);
	int __fastcall Add(System::TObject* Obj);
	__property System::TObject* Objects[int Index] = {read=GetObject, write=SetObject/*, default*/};
	__property int Count = {read=GetObjectsCount, write=SetObjectsCount, nodefault};
	__property bool UpdateWhenUnload = {read=FUpdate, write=FUpdate, nodefault};
	__property bool Protect = {read=FProtect, write=FProtect, nodefault};
	__property bool StaticSize = {read=FStaticSize, write=FStaticSize, nodefault};
};

#pragma pack(pop)

class DELPHICLASS TDataBlock;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TDataBlock : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	void *Data;
	int Size;
	__fastcall TDataBlock(int Size, bool Zero);
	__fastcall virtual ~TDataBlock(void);
};

#pragma pack(pop)

typedef int __fastcall (*TSimpleCompareFunction)(const void *x, const void *y);

class DELPHICLASS TArray;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TArray : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	virtual bool __fastcall GetZero(void) = 0 ;
	virtual void __fastcall SetZero(bool f) = 0 ;
	virtual int __fastcall GetItemSize(void) = 0 ;
	virtual int __fastcall GetCount(void) = 0 ;
	virtual void __fastcall SetCount(int Value) = 0 ;
	virtual void * __fastcall GetItemData(int Index) = 0 ;
	void __fastcall GetItem(int Index, void *Item);
	void __fastcall SetItem(int Index, const void *Item);
	void __fastcall Insert(int Index, const void *Value);
	void __fastcall Append(const void *Value);
	void __fastcall VerifyIndex(int Index);
	void __fastcall ResetItems(int Min, int Max);
	__property void * ItemData[int Index] = {read=GetItemData};
	__property int ItemSize = {read=GetItemSize, nodefault};
	
public:
	void __fastcall Clear(void);
	virtual void __fastcall Exchange(int Index1, int Index2);
	virtual void __fastcall Delete(int Index);
	virtual void __fastcall Sort(TSimpleCompareFunction Compare, int Min, int Max);
	__property int Count = {read=GetCount, write=SetCount, nodefault};
	__property bool Zero = {read=GetZero, write=SetZero, nodefault};
public:
	/* TObject.Create */ inline __fastcall TArray(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TArray(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TCachedArray;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TCachedArray : public TArray
{
	typedef TArray inherited;
	
private:
	int FCount;
	int FBlock;
	TListCache* FStorage;
	int FItemSize;
	bool FZero;
	TDataBlock* __fastcall CreateBlock(void);
	void __fastcall Initialize(void);
	
protected:
	virtual bool __fastcall GetZero(void);
	virtual void __fastcall SetZero(bool f);
	virtual int __fastcall GetItemSize(void);
	virtual int __fastcall GetCount(void);
	virtual void __fastcall SetCount(int Value);
	virtual void * __fastcall GetItemData(int Index);
	
public:
	__fastcall TCachedArray(System::Classes::TStream* DataStream, System::Classes::TStream* ServStream, int Block, int ItemSize)/* overload */;
	__fastcall TCachedArray(System::UnicodeString DataFile, System::UnicodeString ServFile, int Block, int ItemSize)/* overload */;
	__fastcall virtual ~TCachedArray(void);
	virtual void __fastcall Sort(TSimpleCompareFunction Compare, int Min, int Max);
};

#pragma pack(pop)

class DELPHICLASS TIntArrayBase;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TIntArrayBase : public TArray
{
	typedef TArray inherited;
	
public:
	int operator[](int Index) { return Items[Index]; }
	
protected:
	HIDESBASE virtual int __fastcall GetItem(int Index) = 0 ;
	HIDESBASE virtual void __fastcall SetItem(int Index, int Value) = 0 ;
	virtual int __fastcall GetItemSize(void);
	
public:
	HIDESBASE void __fastcall Insert(int Index, int Value);
	HIDESBASE void __fastcall Append(int Value);
	__property int Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TObject.Create */ inline __fastcall TIntArrayBase(void) : TArray() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TIntArrayBase(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TIntArray;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TIntArray : public TIntArrayBase
{
	typedef TIntArrayBase inherited;
	
private:
	typedef System::DynamicArray<int> _TIntArray__1;
	
	
private:
	_TIntArray__1 FArray;
	bool FZero;
	
protected:
	virtual bool __fastcall GetZero(void);
	virtual void __fastcall SetZero(bool f);
	virtual int __fastcall GetItem(int Index);
	virtual void __fastcall SetItem(int Index, int Value);
	virtual int __fastcall GetCount(void);
	virtual void __fastcall SetCount(int Value);
	virtual void * __fastcall GetItemData(int Index);
public:
	/* TObject.Create */ inline __fastcall TIntArray(void) : TIntArrayBase() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TIntArray(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TCachedIntArray;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TCachedIntArray : public TIntArrayBase
{
	typedef TIntArrayBase inherited;
	
private:
	TCachedArray* FArray;
	
protected:
	virtual bool __fastcall GetZero(void);
	virtual void __fastcall SetZero(bool f);
	virtual int __fastcall GetItem(int Index);
	virtual void __fastcall SetItem(int Index, int Value);
	virtual int __fastcall GetCount(void);
	virtual void __fastcall SetCount(int Value);
	virtual void * __fastcall GetItemData(int Index);
	
public:
	__fastcall TCachedIntArray(System::Classes::TStream* DataStream, System::Classes::TStream* ServStream, int Block)/* overload */;
	__fastcall TCachedIntArray(System::UnicodeString DataFile, System::UnicodeString ServFile, int Block)/* overload */;
	__fastcall virtual ~TCachedIntArray(void);
};

#pragma pack(pop)

class DELPHICLASS TExtArrayBase;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TExtArrayBase : public TArray
{
	typedef TArray inherited;
	
public:
	System::Extended operator[](int Index) { return Items[Index]; }
	
protected:
	HIDESBASE virtual System::Extended __fastcall GetItem(int Index) = 0 ;
	HIDESBASE virtual void __fastcall SetItem(int Index, System::Extended Value) = 0 ;
	virtual int __fastcall GetItemSize(void);
	
public:
	HIDESBASE void __fastcall Insert(int Index, System::Extended Value);
	HIDESBASE void __fastcall Append(System::Extended Value);
	__property System::Extended Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TObject.Create */ inline __fastcall TExtArrayBase(void) : TArray() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TExtArrayBase(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TExtArray;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TExtArray : public TExtArrayBase
{
	typedef TExtArrayBase inherited;
	
private:
	typedef System::DynamicArray<System::Extended> _TExtArray__1;
	
	
private:
	_TExtArray__1 FArray;
	bool FZero;
	
protected:
	virtual bool __fastcall GetZero(void);
	virtual void __fastcall SetZero(bool f);
	virtual System::Extended __fastcall GetItem(int Index);
	virtual void __fastcall SetItem(int Index, System::Extended Value);
	virtual int __fastcall GetCount(void);
	virtual void __fastcall SetCount(int Value);
	virtual void * __fastcall GetItemData(int Index);
public:
	/* TObject.Create */ inline __fastcall TExtArray(void) : TExtArrayBase() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TExtArray(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TCachedExtArray;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TCachedExtArray : public TExtArrayBase
{
	typedef TExtArrayBase inherited;
	
private:
	TCachedArray* FArray;
	
protected:
	virtual bool __fastcall GetZero(void);
	virtual void __fastcall SetZero(bool f);
	virtual System::Extended __fastcall GetItem(int Index);
	virtual void __fastcall SetItem(int Index, System::Extended Value);
	virtual int __fastcall GetCount(void);
	virtual void __fastcall SetCount(int Value);
	virtual void * __fastcall GetItemData(int Index);
	
public:
	__fastcall TCachedExtArray(System::Classes::TStream* DataStream, System::Classes::TStream* ServStream, int Block)/* overload */;
	__fastcall TCachedExtArray(System::UnicodeString DataFile, System::UnicodeString ServFile, int Block)/* overload */;
	__fastcall virtual ~TCachedExtArray(void);
};

#pragma pack(pop)

class DELPHICLASS TStreamRW;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TStreamRW : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TStream* FStream;
	bool FSecure;
	int __fastcall GetBoolType(void);
	int __fastcall GetIntType(void);
	int __fastcall GetExtType(void);
	int __fastcall GetStrType(void);
	void __fastcall WriteType(int t);
	void __fastcall ReadType(int t);
	
public:
	__fastcall TStreamRW(System::Classes::TStream* Stream, bool Secure);
	void __fastcall WriteBool(bool x);
	void __fastcall WriteInt(int x);
	void __fastcall WriteExt(System::Extended x);
	void __fastcall WriteStr(System::WideString x);
	bool __fastcall ReadBool(void);
	int __fastcall ReadInt(void);
	System::Extended __fastcall ReadExt(void);
	System::WideString __fastcall ReadStr(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TStreamRW(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TBitArray;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TBitArray : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	typedef System::DynamicArray<System::Byte> _TBitArray__1;
	
	
public:
	bool operator[](int Index) { return Bits[Index]; }
	
private:
	int FLength;
	_TBitArray__1 FData;
	bool __fastcall GetBit(int Index);
	void __fastcall SetBit(int Index, bool Value);
	void __fastcall SetBitsLength(int NewLength);
	void __fastcall Trunc(void);
	
public:
	TBitArray* __fastcall Clone(void);
	void __fastcall ResetBits(void);
	void __fastcall SetBits(void);
	void __fastcall SaveToStream(System::Classes::TStream* Stream);
	int __fastcall GetNumOfSetBits(void);
	int __fastcall GetRightmostBitIndex(void);
	void __fastcall BitOr(TBitArray* Src);
	void __fastcall BitAnd(TBitArray* Src);
	void __fastcall BitXor(TBitArray* Src);
	__property bool Bits[int Index] = {read=GetBit, write=SetBit/*, default*/};
	__property int Length = {read=FLength, write=SetBitsLength, nodefault};
public:
	/* TObject.Create */ inline __fastcall TBitArray(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TBitArray(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __cdecl LhtSetEntry(void * Base, int Index, PLhtEntry Entry);
extern DELPHI_PACKAGE PLhtEntry __cdecl LhtGetEntry(void * Base, int Index);
extern DELPHI_PACKAGE PLhtEntry __cdecl LhtFindEntry(PLhtEntry e, int Key);
extern DELPHI_PACKAGE System::TObject* __fastcall DbRead(System::Classes::TStream* Stream);
extern DELPHI_PACKAGE void __fastcall DbWrite(System::Classes::TStream* Stream, System::TObject* Block);
}	/* namespace Frxstorage */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXSTORAGE)
using namespace Frxstorage;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxstorageHPP
