
# log2(x) =  vgetexp(x) + log2(vgetmant8(x))
@inline function vlog_v1(x1::VectorizationBase.AbstractSIMD{W,Float64}) where {W} # Testing if an assorted mix of operations
    x14 = vgetmant(x1)
    x8 = vgetexp(1.3333333333333333*x1)
    # x2 = reinterpret(UInt64, x1)
    # x3 = x2 >>> 0x0000000000000020
    # greater_than_zero = x1 > zero(x1)
    # alternative = VectorizationBase.ifelse(x1 == zero(x1), -Inf, NaN)
    # isinf = x1 == Inf
    # x5 = x3 + 0x0000000000095f62
    # x6 = x5 >>> 0x0000000000000014
    # x7 = x6 - 0x00000000000003ff
    # x8 = convert(Float64, x7 % Int)
    # @show x3 x5 x6 x7 x8
    # x9 = x5 << 0x0000000000000020
    # x10 = x9 & 0x000fffff00000000
    # x11 = x10 + 0x3fe6a09e00000000
    # x12 = x2 & 0x00000000ffffffff
    # x13 = x11 | x12
    # x14 = reinterpret(Float64, x13)
    x15 = x14 - 1.0
    x18 = x14 + 1.0
    x16 = x15 * x15
    x17 = 0.5 * x16
    x19 = x15 / x18
    x20 = x19 * x19
    x21 = x20 * x20
    x22 = vfmadd(x21, 0.15313837699209373, 0.22222198432149784)
    x23 = vfmadd(x21, x22, 0.3999999999940942)
    x24 = x23 * x21
    x25 = vfmadd(x21, 0.14798198605116586, 0.1818357216161805)
    x29 = x24 + x17
    x26 = vfmadd(x21, x25, 0.2857142874366239)
    x27 = vfmadd(x21, x26, 0.6666666666666735)
    x28 = x27 * x20
    x30 = x29 + x28
    x31 = x8 * 1.9082149292705877e-10
    x32 = vfmadd(x19, x30, x31)
    x33 = x15 - x17
    x34 = x33 + x32
    x35 = vfmadd(x8, 0.6931471803691238, x34)
    return x35
    # @show x35
    # x36 = VectorizationBase.ifelse(greater_than_zero, x35, alternative)
    # VectorizationBase.ifelse(isinf, Inf, x36)
end


const LOGTABLE = [0.0,0.007782140442054949,0.015504186535965254,0.02316705928153438,
    0.030771658666753687,0.0383188643021366,0.0458095360312942,0.053244514518812285,
    0.06062462181643484,0.06795066190850775,0.07522342123758753,0.08244366921107459,
    0.08961215868968714,0.09672962645855111,0.10379679368164356,0.11081436634029011,
    0.11778303565638346,0.12470347850095724,0.13157635778871926,0.13840232285911913,
    0.1451820098444979,0.15191604202584197,0.15860503017663857,0.16524957289530717,
    0.17185025692665923,0.1784076574728183,0.184922338494012,0.19139485299962947,
    0.19782574332991987,0.2042155414286909,0.21056476910734964,0.21687393830061436,
    0.22314355131420976,0.22937410106484582,0.2355660713127669,0.24171993688714516,
    0.24783616390458127,0.25391520998096345,0.25995752443692605,0.26596354849713794,
    0.27193371548364176,0.2778684510034563,0.2837681731306446,0.28963329258304266,
    0.2954642128938359,0.3012613305781618,0.3070250352949119,0.3127557100038969,
    0.3184537311185346,0.324119468654212,0.329753286372468,0.3353555419211378,
    0.3409265869705932,0.34646676734620857,0.3519764231571782,0.3574558889218038,
    0.3629054936893685,0.3683255611587076,0.37371640979358406,0.37907835293496944,
    0.38441169891033206,0.3897167511400252,0.394993808240869,0.4002431641270127,
    0.4054651081081644,0.4106599249852684,0.415827895143711,0.42096929464412963,
    0.4260843953109001,0.4311734648183713,0.43623676677491807,0.4412745608048752,
    0.44628710262841953,0.45127464413945856,0.4562374334815876,0.46117571512217015,
    0.46608972992459924,0.470979715218791,0.4758459048699639,0.4806885293457519,
    0.4855078157817008,0.4903039880451938,0.4950772667978515,0.4998278695564493,
    0.5045560107523953,0.5092619017898079,0.5139457511022343,0.5186077642080457,
    0.5232481437645479,0.5278670896208424,0.5324647988694718,0.5370414658968836,
    0.5415972824327444,0.5461324375981357,0.5506471179526623,0.5551415075405016,
    0.5596157879354227,0.564070138284803,0.5685047353526688,0.5729197535617855,
    0.5773153650348236,0.5816917396346225,0.5860490450035782,0.5903874466021763,
    0.5947071077466928,0.5990081896460834,0.6032908514380843,0.6075552502245418,
    0.6118015411059929,0.616029877215514,0.6202404097518576,0.6244332880118935,
    0.6286086594223741,0.6327666695710378,0.6369074622370692,0.6410311794209312,
    0.6451379613735847,0.6492279466251099,0.6533012720127457,0.65735807270836,
    0.661398482245365,0.6654226325450905,0.6694306539426292,0.6734226752121667,
    0.6773988235918061,0.6813592248079031,0.6853040030989194,0.689233281238809,
    0.6931471805599453];


logb(::Type{Float32},::Val{2})  = 1.4426950408889634
logb(::Type{Float32},::Val{:ℯ}) = One()
logb(::Type{Float32},::Val{10}) = 0.4342944819032518
logbU(::Type{Float64},::Val{2})  = 1.4426950408889634
logbL(::Type{Float64},::Val{2})  = 2.0355273740931033e-17
logbU(::Type{Float64},::Val{:ℯ}) = One()
logbL(::Type{Float64},::Val{:ℯ}) = Zero()
logbU(::Type{Float64},::Val{10}) = 0.4342944819032518
logbL(::Type{Float64},::Val{10}) = 1.098319650216765e-17

@inline function vlog_base(v::AbstractSIMD{W,Float64}) where {W}
  y = vgetmant12(v)
  mf = vgetexp(v)

  y128 = 128.0 * y
  f128 = vsreduce(y128, Val(0))
  F128 = y128 - f128# - 128.0
  jp = convert(UInt,F128) - 0x0000000000000080 # - 128
  # jp = convert(UInt,F128 - 128.0) # - 128
  # jp = convert(UInt,F128) - 0x000000000000007f # - 127
  
  hi = vload(zstridedpointer(LOGTABLE), (jp,))
  # l_hi = muladd(0.6931471805601177, mf, hi)
  l_hi = muladd(0.6931471805599453, mf, hi)

  u = (2.0*f128)/(y128+F128)
  # u = (2.0*f128)*vinv_fast(y128+F128)
  v = u*u
  q = u*v*muladd(0.012500053168098584, v, 0.08333333333303913)

  ## Step 4
  m_hi = logbU(Float64, Val(:ℯ))
  m_lo = logbL(Float64, Val(:ℯ))
  return fma(m_hi, l_hi, fma(m_hi, (u + q), m_lo*l_hi))
end

const LOG_TABLE_1 = Vec((
    Core.VecElement(-0.6931471805599453), Core.VecElement(-0.6325225587435105), Core.VecElement(-0.5753641449035618), Core.VecElement(-0.5212969236332861),
    Core.VecElement(-0.4700036292457356), Core.VecElement(-0.42121346507630353), Core.VecElement(-0.3746934494414107), Core.VecElement(-0.33024168687057687)
))
const LOG_TABLE_2 = Vec((
    Core.VecElement(-0.2876820724517809), Core.VecElement(-0.24686007793152578), Core.VecElement(-0.2076393647782445), Core.VecElement(-0.16989903679539747),
    Core.VecElement(-0.13353139262452263), Core.VecElement(-0.09844007281325252), Core.VecElement(-0.06453852113757118), Core.VecElement(-0.0317486983145803)
))
const LOG2_TABLE_1 = Vec((
    Core.VecElement(-1.0), Core.VecElement(-0.9125371587496606), Core.VecElement(-0.8300749985576876), Core.VecElement(-0.7520724865564145),
    Core.VecElement(-0.6780719051126377),Core.VecElement(-0.6076825772212398), Core.VecElement(-0.5405683813627028),Core.VecElement(-0.4764380439429871)
))
const LOG2_TABLE_2 = Vec((
    Core.VecElement(-0.4150374992788438),Core.VecElement(-0.3561438102252753),Core.VecElement(-0.2995602818589078), Core.VecElement(-0.24511249783653147),
    Core.VecElement(-0.19264507794239588),Core.VecElement(-0.14201900487242788),Core.VecElement(-0.09310940439148147),Core.VecElement(-0.04580368961312479)
))

@inline function logkern_5(x)
    # c5 = 1.442695040910480151153610022148007414933621426294604120324193438507895065110221
    # c4 = -0.72134752044717115185862113438227555323895953631804827391698847566536447158971
    # c3 = 0.4808981720904872241142144122992626169360496403735493070672998980156544684558863
    # c2 = -0.360673694648970133332498335009073996964643657971752173300330580172269152150781
    # c1 = 0.288894281140228357047827707854224408808934973997456175085011693761970856737952
    # c0 = -0.2406712024835816804281715317202731627491220621210104128295077305793044245650939
    # c5 = 1.000000000004163234554825918991486005405540498226964649982446185635197444806964
    # c4 = -0.5000000000218648309257667907050168790946684146132007063399540958947352513227305
    # c3 = 0.3333332566080562266977844691232384812586343066695585749657855454332169568535108
    # c2 = -0.2499998582263749067900056202432438929369945607183640079498376650719435347943278
    # c1 = 0.2002094490921391961924703669397489236496809044839667749701044680362284866088264
    # c0 = -0.1669110816794161712236614512036245351950242871767130610770379611369082994542161
    c5 = 1.442695040894969685206229605569847427762291596137745860941223179497930808392396
    c4 = -0.7213475204760259868264417322489103259481854442059435485772582433076339753304261
    c3 = 0.4808982362718110098786870255779326384270826960362097549483653590161925169305216
    c2 = -0.3606735556861350010148197635190486357722791582949450655689225850005157925747294
    c1 = 0.2888411793443405953870653225945083997249994212173033378047806528684724370915621
    c0 = -0.2408017898083064242160316054616972180231905999993934707245482866675760802361285
    x * vmuladd_fast(vmuladd_fast(vmuladd_fast(vmuladd_fast(vmuladd_fast(c0,x,c1),x,c2),x,c3),x,c4),x,c5)
end
@inline function logkern_8(x)
    c8 = 1.442695040888963407816086035203962841602383176205260263758551036257573600888366
    c7 = -0.7213475204444770815507673261267005370242876005369959065788590988093119140411675
    c6 = 0.4808983469629686528945376971132664305807537133089662498292066034260696561965772
    c5 = -0.360673760285340441741375667112629490399269780822657391947176916709523570522447
    c4 = 0.2885390083116887609918806358733183651489107200432558827730599551390737454696275
    c3 = -0.2404489409194524614303773871505793252012695382714584724417731408820873961880021
    c2 = 0.20609895474146851962537542011143008396458423224465328706920087552924788983302
    c1 = -0.180654273148821532237028827440264938703627661154871403363931834846318112573294
    c0 = 0.1606521926313221723948643034905571707676419356400609690156705532267686492918868
    x * vmuladd_fast(vmuladd_fast(vmuladd_fast(vmuladd_fast(vmuladd_fast(vmuladd_fast(vmuladd_fast(vmuladd_fast(c0,x,c1),x,c2),x,c3),x,c4),x,c5),x,c6),x,c7),x,c8)
end
@inline function logkern_9(x)
    c9 = 1.442695040888963407587958876357516873223860332904434711906078224014586198339343
    c8 = -0.7213475204444817057711203479236040464424888160067823280588699959470059217833771
    c7 = 0.480898346962976128170017519528240603877475137860740135494448418612334521964808
    c6 = -0.3606737602222044528926485178925468152698544632914287402177742224438034341355266
    c5 = 0.2885390082734153359755295484533201676037233143490110170185338945645707433116462
    c4 = -0.2404491736638805517094434611266213341107664043116792359649609367170386448753448
    c3 = 0.2060990174486639706727491347594731948792605354335332681880496880277396108033051
    c2 = -0.1803364995021978052782243890647317433194251060644842283875753942662516598663569
    c1 = 0.1606200865414345528500280443621751155379142697854250695344975262087060612426921
    c0 = -0.1446222903636375678552838798467050326611974502493221959482776774515654211467748
    x * vmuladd_fast(vmuladd_fast(vmuladd_fast(vmuladd_fast(vmuladd_fast(vmuladd_fast(vmuladd_fast(vmuladd_fast(vmuladd_fast(c0,x,c1),x,c2),x,c3),x,c4),x,c5),x,c6),x,c7),x,c8),x,c9)
end
@inline function logkern_7(x)
    c7 = 1.442695040888962266311320415441181965256745101864924017704730474290825179713386
    c6 = -0.7213475204444734849561916107798427186725025515630934214552341603017790847666743
    c5 = 0.4808983470003734483568608991659360631657097156445816019788134536213757250523677
    c4 = -0.3606737603148037624174654830835163329225507561910479104865837838596482628691627
    c3 = 0.2885388167992364548202154388340846682584745440281798969580530860342799719518947
    c2 = -0.2404488805785497044335968015014331102915764909299868970339917618519049206072763
    c1 = 0.2064127286335890836287774329056506792116396261746810041599847620260037837288407
    c0 = -0.1806895812056507095939337124225687685035687284931465242170306355644855623118632
    # c7 = 1.442695040888962266311320415440673226691509089399247319200433080789551133947874
    # c6 = -0.7213475204444734849561916106463536879222835723990934589483454213207143172699565
    # c5 = 0.4808983470003734483568609116686822486155905301580259810441289744019151890859293
    # c4 = -0.3606737603148037624174668433501054879718352818773442452949795967039102009618056
    # c3 = 0.2885388167992364548201727628199776711909314676794911979761485405529591339257216
    # c2 = -0.2404488805785497044302647238681858349839732924674030562755638231437855429968676
    # c1 = 0.2064127286335890836637376093489490181845837682333985654448331246682934490703086
    # c0 = -0.1806895812056507118633103913062383463992924441916921974716424429045368328209497
    x * vmuladd_fast(vmuladd_fast(vmuladd_fast(vmuladd_fast(vmuladd_fast(vmuladd_fast(vmuladd_fast(c0,x,c1),x,c2),x,c3),x,c4),x,c5),x,c6),x,c7)
end
@inline function logkern_6(x)
    c6 = 1.44269504088896112481574913926580271258562668309654298701097420877374680031478
    c5 = -0.7213475204628791729494574154147857065200754915843724028524643433219030089552769
    c4 = 0.4808983470214135184345854322580473442742138878734777669129377480116915710051349
    c3 = -0.3606736095355376179878548883602333628571188158521650924319649055538192403728833
    c2 = 0.2885387593457860540619732799086814986482101737149964973666904711488634555687257
    c1 = -0.2407576763559816924463087687841796294903125418141104155734727426854999960321288
    c0 = 0.2064519502023243513328580164119739425968179159770070826936661162470222233739379
    x * vmuladd_fast(vmuladd_fast(vmuladd_fast(vmuladd_fast(vmuladd_fast(vmuladd_fast(c0,x,c1),x,c2),x,c3),x,c4),x,c5),x,c6)
end

# Probably the best
@inline function vlog2_fast(a::AbstractSIMD{8,Float64})
    # log2(vgetmant(a, Val(8))) + vgetexp(a) == log2(a)
    m = vgetmant(a, Val(8)) # m ∈ [1,2)
    e = vgetexp(a)
    # m ∈ [1,2); We reduce further...
    y = inv_approx(m) # y ∈ (0.5,1]
    # return y
    y₀ = vroundscale(y, Val(80)) # 80 = 16*(1+4)
    # y₀ is a multiple of 32; 0.5:(1/32):1.0
    # log2(m) = y * x = log2(y) + log2(x)
    # r = x - 1
    # r + 1 = m*y;
    # log(r+1) = log(m) + log(y₀)
    # log(m) = log(1+r) - log(y₀)
    r = vfmsub(m, y₀, 1.0) # m * y - 1 
    log1pr = logkern_5(r)
    # log1pr = logkern_6(r)
    # log1pr = logkern_7(r)
    # log1pr = logkern_9(r)
    # @show r log1pr m
    # log1pr = logkern_8(r)
    y₀notone = y₀ ≠ 1.0
    inds = (reinterpret(UInt, y₀) >>> 48) & 0x0f
    # @show y₀ inds r
    # logy₀ = vpermi2pd(inds, LOG2_TABLE_1, LOG2_TABLE_2)
    logy₀ = vpermi2pd(inds, LOG2_TABLE_1, LOG2_TABLE_2)
    # emlogy₀ = e - logy₀
    emlogy₀ = ifelse(y₀notone, e - logy₀, e)
    log1pr + emlogy₀ 
    # logm = ifelse(y₀notone, log1pr - logy₀, log1pr)
    # @show r y₀ e
    # return r, m, y₀, logy₀, e
    # logkern_5(r) - logy₀ + e
    # logm = ifelse(y₀isone, log1pr, log1pr - logy₀)
    # log1pr += e
    
    # logm = ifelse(y₀notone, log1pr - logy₀, log1pr)
    # @show logm log1pr logy₀ e
    # logm + e
end
@inline vlog_fast(x::T) where {T} = vlog2_fast(x) * convert(T, 0.6931471805599453)
@inline vlog10_fast(x::T) where {T} = vlog2_fast(x) * convert(T, 0.3010299956639812)
# @inline Base.FastMath.log_fast(v::AbstractSIMD) = vlog_fast(float(v))
# @inline Base.FastMath.log2_fast(v::AbstractSIMD) = vlog2_fast(float(v))
# @inline Base.FastMath.log10_fast(v::AbstractSIMD) = vlog10_fast(float(v))

@inline function log2_kern_5_256(x)
    c5 = 1.442695040888963430242018860033667730529246266516984575206349078995811595149434
    c4 = -0.7213475204444818238116304451613321925305725926194819917643836452178866375548279
    c3 = 0.480898346935995048804761640936874918715608085587068841980211938177173076051027
    c2 = -0.3606737601723789903264415189400867418476075783130968675245051405508304609911771
    c1 = 0.2885437254815682617764304037319501313717679206671517967342968352103864725323379
    c0 = -0.2404546770228689226321452773936263107841762894627528631584290286000941540854746
    x * vmuladd_fast(vmuladd_fast(vmuladd_fast(vmuladd_fast(vmuladd_fast(c0,x,c1),x,c2),x,c3),x,c4),x,c5)
end

const LOG2_TABLE_128 = Float64[log2(x) for x ∈  range(big"0.5", step = 1/256, length = 128)]

@inline function vlog2_v2(a::AbstractSIMD{W,Float64}) where {W}
    # log2(vgetmant(a, Val(8))) + vgetexp(a) == log2(a)
    m = vgetmant(a, Val(8)) # m ∈ [1,2)
    e = vgetexp(a)
    # m ∈ [1,2); We reduce further...
    y = inv_approx(m) # y ∈ (0.5,1]
    # return y
    y₀ = vroundscale(y, Val(128)) # 80 = 16*(1+7)

    # y₀ is a multiple of 32; 0.5:
    # r + 1 = m*y;
    # log(r+1) = log(m) + log(y₀)
    # log(m) = log(1+r) - log(y₀)
    r = vfmsub(m, y₀, 1.0)
    # log1pr = logkern_5(r)
    log1pr = log2_kern_5_256(r)
    y₀notone = y₀ ≠ 1.0
    inds = (reinterpret(Int, y₀) >> 45) & 0xff
    # inds = (reinterpret(UInt, y₀) >>> 48) & 0x0f
    # @show y₀ inds r
    # logy₀ = vpermi2pd(inds, LOG2_TABLE_1, LOG2_TABLE_2)
    logy₀ = vload(zstridedpointer(LOG2_TABLE_128), (inds,))

    emlogy₀ = ifelse(y₀notone, e - logy₀, e)
    log1pr + emlogy₀ 
end

# @inline function Base.log(x1::AbstractSIMD{W,Float64}) where {W}
# @inline function vlog(x1::Float64)
# @inline Base.log(v::AbstractSIMD) = log(float(v))

# @inline function vlog_fast(x1::AbstractSIMD{W,Float32}) where {W}
#     notzero = x1 != zero(x1)
#     greater_than_zero = x1 > zero(x1)
#     x3 = x1 < 1.1754944f-38#3.4332275f-5
#     # x6 = true if x3 entirely false
#     x7 = x1 * 8.388608f6#14.0f0
#     x8 = ifelse(x3, x7, x1)
#     x10 = reinterpret(UInt32, x8)
#     x11 = x10 + 0x004afb0d
#     x12 = x11 >>> 0x00000017
#     x13 = ifelse(x3, 0xffffff6a, 0xffffff81)
#     x15 = x12 + x13
#     x16 = x11 & 0x007fffff
#     x17 = x16 + 0x3f3504f3
#     x18 = reinterpret(Float32, x17)
#     x19 = x18 - 1f0
#     x20 = x18 + 1f0
#     x21 = x19 / x20
#     x22 = x21 * x21
#     x23 = x22 * x22
#     x24 = vfmadd(x23, 0.24279079f0, 0.40000972f0)
#     x25 = x24 * x23
#     x26 = vfmadd(x23, 0.6666666f0, 0.6666666f0)
#     x27 = x26 * x22
#     x28 = x19 * x19
#     x29 = x28 * 5f-1
#     x30 = convert(Float32, x15 % Int32)
#     x31 = x27 + x29
#     x32 = x31 + x25
#     x33 = x30 * -0.00021219444f0
#     x34 = vfmadd(x21, x32, x33)
#     x35 = x19 - x29
#     x36 = x35 + x34
#     x37 = vfmadd(x30, 0.6933594f0, x36)
#     # x37 = vfmadd(x30, 0.6931472f0, x36)
#     x39 = ifelse(x1 == Inf32, Inf32, x37)
#     x40 = ifelse(notzero, x39, -Inf32)
#     ifelse(x1 < zero(x1), NaN32, x40)
# end
# @inline Base.FastMath.log_fast(v::AbstractSIMD) = vlog_fast(float(v))


