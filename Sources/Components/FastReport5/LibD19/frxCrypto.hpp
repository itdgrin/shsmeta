// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxCrypto.pas' rev: 26.00 (Windows)

#ifndef FrxcryptoHPP
#define FrxcryptoHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxcrypto
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TCryptoRC4;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TCryptoRC4 : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::StaticArray<System::Byte, 256> FS;
	System::Byte FI;
	System::Byte FJ;
	
public:
	void __fastcall Init(const void *Key, int Len);
	void __fastcall Encrypt(void * Data, int Size);
public:
	/* TObject.Create */ inline __fastcall TCryptoRC4(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TCryptoRC4(void) { }
	
};

#pragma pack(pop)

typedef System::StaticArray<System::Byte, 16> TCryptoAESMatrix;

typedef System::StaticArray<System::Byte, 256> TCryptoAESSBox;

typedef System::StaticArray<System::Byte, 4> TCryptoAESDiffuseRow;

class DELPHICLASS TCryptoAES;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TCryptoAES : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	typedef System::DynamicArray<TCryptoAESMatrix> _TCryptoAES__1;
	
	
private:
	int FNr;
	_TCryptoAES__1 FW;
	__classmethod void __fastcall InitSBox();
	__classmethod int __fastcall Mul8(int a, int b);
	
protected:
	__classmethod void __fastcall MatrixToData(/* out */ void *Data, const TCryptoAESMatrix &a);
	__classmethod void __fastcall DataToMatrix(/* out */ TCryptoAESMatrix &a, const void *Data);
	void __fastcall Sum(TCryptoAESMatrix &a, const TCryptoAESMatrix &b, const TCryptoAESMatrix &c);
	void __fastcall Mov(TCryptoAESMatrix &a, const TCryptoAESMatrix &b);
	void __fastcall Zero(TCryptoAESMatrix &a);
	void __fastcall Apply(TCryptoAESMatrix &a, const TCryptoAESSBox &Box);
	void __fastcall Rotate(TCryptoAESMatrix &a, int Dir);
	void __fastcall Diffuse(TCryptoAESMatrix &a, const TCryptoAESDiffuseRow DiffuseRow);
	void __fastcall ExpandKey(System::Byte const *Key, const int Key_Size);
	virtual void __fastcall Encrypt(TCryptoAESMatrix &a)/* overload */;
	virtual void __fastcall Decrypt(TCryptoAESMatrix &a)/* overload */;
	
public:
	__fastcall TCryptoAES(System::Byte const *Key, const int Key_Size);
	virtual void __fastcall Encrypt(void *Output, const void *Input)/* overload */;
	virtual void __fastcall Decrypt(void *Output, const void *Input)/* overload */;
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCryptoAES(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS ECryptoAESException;
#pragma pack(push,4)
class PASCALIMPLEMENTATION ECryptoAESException : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ECryptoAESException(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ECryptoAESException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : System::Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall ECryptoAESException(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ECryptoAESException(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ECryptoAESException(NativeUInt Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateResFmt */ inline __fastcall ECryptoAESException(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall ECryptoAESException(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ECryptoAESException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ECryptoAESException(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ECryptoAESException(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ECryptoAESException(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ECryptoAESException(NativeUInt Ident, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ECryptoAESException(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS ECryptoAESInvalidKeyLength;
#pragma pack(push,4)
class PASCALIMPLEMENTATION ECryptoAESInvalidKeyLength : public ECryptoAESException
{
	typedef ECryptoAESException inherited;
	
public:
	/* Exception.Create */ inline __fastcall ECryptoAESInvalidKeyLength(const System::UnicodeString Msg) : ECryptoAESException(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ECryptoAESInvalidKeyLength(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : ECryptoAESException(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall ECryptoAESInvalidKeyLength(NativeUInt Ident)/* overload */ : ECryptoAESException(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ECryptoAESInvalidKeyLength(System::PResStringRec ResStringRec)/* overload */ : ECryptoAESException(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ECryptoAESInvalidKeyLength(NativeUInt Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : ECryptoAESException(Ident, Args, Args_Size) { }
	/* Exception.CreateResFmt */ inline __fastcall ECryptoAESInvalidKeyLength(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size)/* overload */ : ECryptoAESException(ResStringRec, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall ECryptoAESInvalidKeyLength(const System::UnicodeString Msg, int AHelpContext) : ECryptoAESException(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ECryptoAESInvalidKeyLength(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : ECryptoAESException(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ECryptoAESInvalidKeyLength(NativeUInt Ident, int AHelpContext)/* overload */ : ECryptoAESException(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ECryptoAESInvalidKeyLength(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : ECryptoAESException(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ECryptoAESInvalidKeyLength(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : ECryptoAESException(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ECryptoAESInvalidKeyLength(NativeUInt Ident, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : ECryptoAESException(Ident, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ECryptoAESInvalidKeyLength(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS ECryptoAESInvalidBlockSize;
#pragma pack(push,4)
class PASCALIMPLEMENTATION ECryptoAESInvalidBlockSize : public ECryptoAESException
{
	typedef ECryptoAESException inherited;
	
public:
	/* Exception.Create */ inline __fastcall ECryptoAESInvalidBlockSize(const System::UnicodeString Msg) : ECryptoAESException(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ECryptoAESInvalidBlockSize(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : ECryptoAESException(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall ECryptoAESInvalidBlockSize(NativeUInt Ident)/* overload */ : ECryptoAESException(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ECryptoAESInvalidBlockSize(System::PResStringRec ResStringRec)/* overload */ : ECryptoAESException(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ECryptoAESInvalidBlockSize(NativeUInt Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : ECryptoAESException(Ident, Args, Args_Size) { }
	/* Exception.CreateResFmt */ inline __fastcall ECryptoAESInvalidBlockSize(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size)/* overload */ : ECryptoAESException(ResStringRec, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall ECryptoAESInvalidBlockSize(const System::UnicodeString Msg, int AHelpContext) : ECryptoAESException(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ECryptoAESInvalidBlockSize(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : ECryptoAESException(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ECryptoAESInvalidBlockSize(NativeUInt Ident, int AHelpContext)/* overload */ : ECryptoAESException(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ECryptoAESInvalidBlockSize(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : ECryptoAESException(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ECryptoAESInvalidBlockSize(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : ECryptoAESException(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ECryptoAESInvalidBlockSize(NativeUInt Ident, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : ECryptoAESException(Ident, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ECryptoAESInvalidBlockSize(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TCryptoAES_CBC;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TCryptoAES_CBC : public TCryptoAES
{
	typedef TCryptoAES inherited;
	
private:
	TCryptoAESMatrix FC;
	
protected:
	virtual void __fastcall Encrypt(TCryptoAESMatrix &a)/* overload */;
	virtual void __fastcall Decrypt(TCryptoAESMatrix &a)/* overload */;
	
public:
	__fastcall TCryptoAES_CBC(System::Byte const *Key, const int Key_Size, const void *IV);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCryptoAES_CBC(void) { }
	
/* Hoisted overloads: */
	
public:
	inline void __fastcall  Encrypt(void *Output, const void *Input){ TCryptoAES::Encrypt(Output, Input); }
	inline void __fastcall  Decrypt(void *Output, const void *Input){ TCryptoAES::Decrypt(Output, Input); }
	
};

#pragma pack(pop)

class DELPHICLASS TCryptoCMWC;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TCryptoCMWC : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	typedef System::DynamicArray<unsigned> _TCryptoCMWC__1;
	
	
private:
	unsigned FMultiplier;
	_TCryptoCMWC__1 FSeed;
	unsigned FCarry;
	int FNext;
	
public:
	__fastcall TCryptoCMWC(unsigned a, unsigned r);
	unsigned __fastcall Next(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCryptoCMWC(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TCryptoHash;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TCryptoHash : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	typedef System::DynamicArray<System::Byte> _TCryptoHash__1;
	
	
private:
	_TCryptoHash__1 FChunk;
	int FLength;
	
protected:
	__fastcall TCryptoHash(int ChunkSize)/* overload */;
	virtual void __fastcall Process(System::Byte const *Chunk, const int Chunk_Size) = 0 ;
	virtual void __fastcall Finish(int LengthSize, bool Straight);
	
public:
	__classmethod TCryptoHash* __fastcall Create(const System::UnicodeString Name)/* overload */;
	__classmethod void __fastcall Hash(const System::UnicodeString Name, void *Digest, int DigestSize, const void *Data, int Size)/* overload */;
	__classmethod void __fastcall Hash(const System::UnicodeString Name, void *Digest, int DigestSize, const System::AnsiString s)/* overload */;
	virtual void __fastcall Reset(void);
	void __fastcall Push(System::Byte b)/* overload */;
	void __fastcall Push(const void *Data, int Size)/* overload */;
	void __fastcall Push(System::Classes::TStream* Stream)/* overload */;
	virtual void __fastcall GetDigest(/* out */ void *Digest, int Size) = 0 ;
	virtual int __fastcall DigestSize(void) = 0 ;
	int __fastcall ChunkSize(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCryptoHash(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS ECryptoHash;
#pragma pack(push,4)
class PASCALIMPLEMENTATION ECryptoHash : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ECryptoHash(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ECryptoHash(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : System::Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall ECryptoHash(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ECryptoHash(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ECryptoHash(NativeUInt Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateResFmt */ inline __fastcall ECryptoHash(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall ECryptoHash(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ECryptoHash(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ECryptoHash(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ECryptoHash(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ECryptoHash(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ECryptoHash(NativeUInt Ident, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ECryptoHash(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS ECryptoHashUnknown;
#pragma pack(push,4)
class PASCALIMPLEMENTATION ECryptoHashUnknown : public ECryptoHash
{
	typedef ECryptoHash inherited;
	
public:
	__fastcall ECryptoHashUnknown(System::UnicodeString Name);
public:
	/* Exception.CreateFmt */ inline __fastcall ECryptoHashUnknown(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : ECryptoHash(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall ECryptoHashUnknown(NativeUInt Ident)/* overload */ : ECryptoHash(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ECryptoHashUnknown(System::PResStringRec ResStringRec)/* overload */ : ECryptoHash(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ECryptoHashUnknown(NativeUInt Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : ECryptoHash(Ident, Args, Args_Size) { }
	/* Exception.CreateResFmt */ inline __fastcall ECryptoHashUnknown(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size)/* overload */ : ECryptoHash(ResStringRec, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall ECryptoHashUnknown(const System::UnicodeString Msg, int AHelpContext) : ECryptoHash(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ECryptoHashUnknown(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : ECryptoHash(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ECryptoHashUnknown(NativeUInt Ident, int AHelpContext)/* overload */ : ECryptoHash(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ECryptoHashUnknown(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : ECryptoHash(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ECryptoHashUnknown(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : ECryptoHash(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ECryptoHashUnknown(NativeUInt Ident, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : ECryptoHash(Ident, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ECryptoHashUnknown(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TCryptoMD5;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TCryptoMD5 : public TCryptoHash
{
	typedef TCryptoHash inherited;
	
private:
	System::StaticArray<int, 4> FState;
	__classmethod void __fastcall InitSinTable();
	void __fastcall InitState(void);
	
protected:
	virtual void __fastcall Process(System::Byte const *Chunk, const int Chunk_Size);
	
public:
	__fastcall TCryptoMD5(void);
	virtual void __fastcall GetDigest(/* out */ void *Digest, int Size);
	virtual void __fastcall Reset(void);
	virtual int __fastcall DigestSize(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCryptoMD5(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TCryptoSHA1;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TCryptoSHA1 : public TCryptoHash
{
	typedef TCryptoHash inherited;
	
private:
	System::StaticArray<int, 5> FState;
	void __fastcall InitState(void);
	
protected:
	virtual void __fastcall Process(System::Byte const *Chunk, const int Chunk_Size);
	
public:
	__fastcall TCryptoSHA1(void);
	virtual void __fastcall GetDigest(/* out */ void *Digest, int Size);
	virtual void __fastcall Reset(void);
	virtual int __fastcall DigestSize(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCryptoSHA1(void) { }
	
};

#pragma pack(pop)

typedef System::StaticArray<System::StaticArray<System::Byte, 8>, 8> TCryptoWhirlpoolMatrix;

class DELPHICLASS TCryptoWhirlpool;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TCryptoWhirlpool : public TCryptoHash
{
	typedef TCryptoHash inherited;
	
private:
	TCryptoWhirlpoolMatrix FState;
	void __fastcall ApplySBox(TCryptoWhirlpoolMatrix &a);
	void __fastcall Rotate(TCryptoWhirlpoolMatrix &a);
	void __fastcall Diffuse(TCryptoWhirlpoolMatrix &a);
	void __fastcall Transform(TCryptoWhirlpoolMatrix &a, const TCryptoWhirlpoolMatrix &b);
	void __fastcall InitState(void);
	void __fastcall Sum(TCryptoWhirlpoolMatrix &a, const TCryptoWhirlpoolMatrix &b, const TCryptoWhirlpoolMatrix &c);
	void __fastcall Encrypt(TCryptoWhirlpoolMatrix &w, const TCryptoWhirlpoolMatrix &a, const TCryptoWhirlpoolMatrix &b);
	
protected:
	virtual void __fastcall Process(System::Byte const *Chunk, const int Chunk_Size);
	
private:
	__classmethod void __fastcall InitSBox();
	__classmethod void __fastcall InitMul8();
	__classmethod int __fastcall Mul4(int a, int b);
	__classmethod int __fastcall Mul8(int a, int b);
	__classmethod int __fastcall Mul8NoCache(int a, int b);
	
public:
	__fastcall TCryptoWhirlpool(void);
	virtual void __fastcall GetDigest(/* out */ void *Digest, int Size);
	virtual void __fastcall Reset(void);
	virtual int __fastcall DigestSize(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCryptoWhirlpool(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TCryptoJenkins;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TCryptoJenkins : public TCryptoHash
{
	typedef TCryptoHash inherited;
	
private:
	unsigned FState;
	
protected:
	virtual void __fastcall Finish(int LengthSize, bool Straight);
	virtual void __fastcall Process(System::Byte const *Chunk, const int Chunk_Size);
	
public:
	__fastcall TCryptoJenkins(void);
	virtual void __fastcall GetDigest(/* out */ void *Digest, int Size);
	virtual void __fastcall Reset(void);
	virtual int __fastcall DigestSize(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCryptoJenkins(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxcrypto */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXCRYPTO)
using namespace Frxcrypto;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxcryptoHPP
