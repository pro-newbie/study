# RMS 타이타닉 침몰사고관련 여객 정보

- 생존자 수 분석 : 생존자 수와 사망자 수를 비교 시각화 -> 생존률에 영향을 미치는 요인을 분석
- 객실 등급별 분석 : Pclass에 따른 분석 -> 객실 등급이 생존에 미치는 영향을
- 성별에 따른 생존률 분석 : 성별에 따른 분석률
- 나이 분포 및 연령대별 생존률
- 탑승 항구 별 승객 분석 : 승객의 분포와 생존율 등

>`import pandas as pd`   
>`import numpy as np`   
>`import seaborn as sns`  # 파이썬 모듈 중 통계 시각화 라이브러리    
>`import matplotlib.pyplot as plt`   
>`titanic = sns.load_dataset('titanic')`  #RMS 타이타닉 침몰사고관련 여객 정보     

### q1. 기본 정보를 확인하자. info() : 열이름, 데이터 타입, 결측치 여부 , 메모리 사용량 확인
- 'survived' :승객의 생존 유무(0:사망, 1=생존)
- 'pclass' : 티켓클래스 (1= 1등석, 2= 2등석, 3= 3등석) , 사회 경제적 위치
- 'sex', : 성별 'age', : 나이
- 'sibsp', : 탑승 형제, 자매, 배우자등의 수
- 'parch' : 부모, 자녀의 수
- 'fare', : 요금
- 'embarked', : 승객이 탑승한 항구(C=쉘부르 , Q =퀸스타운 , S = 사우스햄프턴)
- 'class' =category : 티켓을 문자열로 표현 First, Second,Third등 ,"pclass"의 카테고리 버전
- 'who', : 승객을 man, woman, child로 구분 ('sex','age' 데이터를 기반으로 결정)
- 'adult_male',: 승객이 성인 남성 유무 ('sex','age' 데이터를 기반으로 결정)
- 'deck',: 객실의 데크 'cabin'데이터 에서 추출된 첫번째 문자 , A,B,C로 표시한다.
- 'embark_town': 탑승항구 도시 'embarked'의 상세 버전 Cherbourg, Queenstown, Southampton
- 'alive', : 생존 유무 'survived'의 문자열 버전
- 'alone' : 혼자 탑승햇는지 유무 , sibsp,parch의 데이터를 기반으로 생성

### 성별, 나이, 가족관계, 사회 경제적 위치 등을 통한 승객분석
> 'titanic.info()'   
<class 'pandas.core.frame.DataFrame'>   
RangeIndex: 891 entries, 0 to 890   
Data columns (total 15 columns):   

|**###**|**Column**|**Non-Null**|**Count**|**Dtype**| 
|--- |    ---       |   ---    | ---  |   ---  | 
| 0  |  survived    | 891 non-null  |  int64   |  
| 1  |  pclass      | 891 non-null  |  int64   |
| 2  |  sex         | 891 non-null  |  object  |
| 3  |  age         | 714 non-null  |  float64 |
| 4  |  sibsp       | 891 non-null  |  int64   |
| 5  |  parch       | 891 non-null  |  int64   |
| 6  |  fare        | 891 non-null  |  float64 |
| 7  |  embarked    | 889 non-null  |  object  |
| 8  |  class       | 891 non-null  |  category|
| 9  |  who         | 891 non-null  |  object  |
| 10 |  adult_male  | 891 non-null  |  bool    |
| 11 |  deck        | 203 non-null  |  category|
| 12 |  embark_town | 889 non-null  |  object  |
| 13 |  alive       | 891 non-null  |  object  |
| 14 |  alone       | 891 non-null  |  bool    |

> dtypes: bool(2), category(2), float64(2), int64(4), object(5)   
> memory usage: 80.7+ KB   

### Q1.승객목록 보기

`titanic.head()`   
|**survived**|**pclass**|**sex**|**age**|**sibsp**|**parch**|**fare**|**embarked**|**class**|**who**|**adult_male**|**deck**|**embark_town**|**alive**|**alone**|
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
|0|0|3|male|22.0|1|0|7.2500|S|Third|man	True|NaN|Southampton|no|False|
|1|1|1|female|38.0|1|0|71.2833|C|First|woman|False|C|Cherbourg|yes|False|
|2|1|3|female|26.0|0|0|7.9250|S|Third|woman|False|NaN|Southampton|yes|True|
|3|1|1|female|35.0|1|0|53.1000|S|First|woman|False|C|Southampton|yes|False|
|4|0|3|male|35.0|0|0|8.0500|S|Third|man|True|NaN|Southampton|no|True|

### Q2.생존 현황보기

`titanic.groupby('survived').count()`   
|###|**pclass**|**sex**|**age**|**sibsp**|**parch**|**fare**|**embarked**|**class**|**who**|**adult_male**|**deck**|**embark_town**|**alive**|**alone**|
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
|survived|-|-|-|-|-|-|-|-|-|-|-|-|-|-|											
|0|549|549|424|549|549|549|549|549|549|549|67|549|549|549|
|1|342|342|290|342|342|342|340|342|342|342|136|340|342|342|

### Q3. 탑승 클래스 보기

# 탑승 클래스별 뷰
`titanic.groupby('class').count()`
​
|###|**survived**|**pclass**|**sex**|**age**|**sibsp**|**parch**|**fare**|**embarked**|**who**|**adult_male**|**deck**|**embark_town**|**alive**|**alone**|
|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|
|class|-|-|-|-|-|-|-|-|-|-|-|-|-|-|														
|First|216|216|216|186|216|216|216|214|216|216|175|214|216|216|
|Second|184|184|184|173|184|184|184|184|184|184|16|184|184|184|
|Third|491|491|491|355|491|491|491|491|491|491|12|491|491|491|

### Q4. 연령별 그룹을 확인하자.
`pandas.cut(x, bins, right=True, labels=None, retbins=False, precision=3, include_lowest=False, duplicates='raise', ordered=True)`

### pd.cut()을 사용해서 연령대 그룹별 집계를 구현하자.
`age_bins = [0, 12, 18, 60, 120]`
`age_labels = ['Child', 'Teen', 'Adult', 'Senior']`
`titanic['age_group'] = pd.cut(titanic['age'],bins = age_bins, labels = age_labels)`
`titanic.groupby('age_group').count()`

|-|**survived**|**pclass**|**sex**|**age**|**sibsp**|**parch**|**fare**|**embarked**|**class**|**who**|**adult_male**|**deck**|**embark_town**|**alive**|**alone**|
|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|	
|age_group|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|						
|Child|69|69|69|69|69|69|69|69|69|69|69|11|69|69|69|
|Teen|70|70|70|70|70|70|70|70|70|70|70|12|70|70|70|
|Adult|	553|553|553|553|553|553|553|552|553|553|553|150|552|553|553|
|Senior|22|22|22|22|22|22|22|21|22|22|22|11|21|22|22|

### Q5. 성별 생존률 집계를 내보자.

`titanic.groupby('sex').count()`
|-|survived|pclass|age|sibsp|parch|fare|embarked|class|who|adult_male|deck|embark_town|alive|alone|age_group|
|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|
|sex|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|															
|female|314|314|261|314|314|314|312|314|314314|97|312|314|314|261|
|male|577|577|453|577|577|577|577|577|577|577|106|577|577|577|453|

### Q6. 요금 구간별 뷰를 구현하고 집계를 내보자.
* pandas.cut(x, bins, right=True, labels=None, retbins=False, precision=3, include_lowest=False, duplicates='raise', ordered=True)

`titanic['fare'].max(), titanic['fare'].min(), titanic['fare'].mean()`
> (512.3292, 0.0, 32.204207968574636)

`fare_bins = [0,10,20,50,100,500]`
`fare_labels = ['0-10', '10-20', '20-50', '50-100', '100+']`
`titanic['fare_bracket'] = pd.cut(titanic['fare'], bins = fare_bins, labels = fare_labels)`
`titanic.groupby('fare_bracket').count()`

|-|survived|pclass|sex|age|sibsp|parch|fare|embarked|class|who|adult_male|deck|embark_town|alive|alone|age_group|
|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|
|fare_bracket|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|																
|0-10|321|321|321|229|321|321|321|321|321|321|321|6|321|321|321|229|
|10-20|179|179|179|155|179|179|179|179|179|179|179|17|179|179|179|155|
|20-50|216|216|216|185|216|216|216|216|216|216|216|56|216|216|216|185|
|50-100|107|107|107|90|107|107|107|105|107|107|107|78|105|107|107|90|
|100+|	50|	50|	50|	45|	50|	50|	50|	50|	50|	50|	50|	41|	50|	50|	50|	45|

### Q8. 가족/ 동행자수별 생존의 집계를 확인 해보자.

`titanic['family_size'] = titanic['sibsp'] + titanic['parch']`
`titanic.groupby('family_size').count()`

|-|survived|pclass|sex|age|sibsp|parch|fare|embarked|class|who|adult_male|deck|embark_town|alive|alone|age_group|	fare_bracket|
|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|
|family_size|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|																	
|0|	537|	537|	537|	404|	537|	537|	537|	535	537	537	537	93	535	537	537	404	520
1	161	161	161	139	161	161	161	161	161	161	161	66	161	161	161	139	160
2	102	102	102	93	102	102	102	102	102	102	102	29	102	102	102	93	102
3	29	29	29	27	29	29	29	29	29	29	29	9	29	29	29	27	29
4	15	15	15	11	15	15	15	15	15	15	15	2	15	15	15	11	15
5	22	22	22	22	22	22	22	22	22	22	22	4	22	22	22	22	22
6	12	12	12	12	12	12	12	12	12	12	12	0	12	12	12	12	12
7	6	6	6	6	6	6	6	6	6	6	6	0	6	6	6	6	6
10	7	7	7	0	7	7	7	7	7	7	7	0	7	7	7	0	7

### Q9. 승선 장소별 집계를 확인하자.

titanic.groupby('embarked').count()
titanic.groupby('embark_town').count()
survived	pclass	sex	age	sibsp	parch	fare	embarked	class	who	adult_male	deck	alive	alone	age_group	fare_bracket	family_size
embark_town																	
Cherbourg	168	168	168	130	168	168	168	168	168	168	168	69	168	168	130	165	168
Queenstown	77	77	77	28	77	77	77	77	77	77	77	4	77	77	28	77	77
Southampton	644	644	644	554	644	644	644	644	644	644	644	128	644	644	554	629	644

### Q10. 갑판별 집계를 확인하자. (객실정보(cabin)의 첫글자로 데이터 구성)

titanic.groupby('deck').count()
survived	pclass	sex	age	sibsp	parch	fare	embarked	class	who	adult_male	embark_town	alive	alone	age_group	fare_bracket	family_size
deck																	
A	15	15	15	12	15	15	15	15	15	15	15	15	15	15	12	14	15
B	47	47	47	45	47	47	47	45	47	47	47	45	47	47	45	43	47
C	59	59	59	51	59	59	59	59	59	59	59	59	59	59	51	59	59
D	33	33	33	31	33	33	33	33	33	33	33	33	33	33	31	33	33
E	32	32	32	30	32	32	32	32	32	32	32	32	32	32	30	32	32
F	13	13	13	11	13	13	13	13	13	13	13	13	13	13	11	13	13
G	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4

### Q12. 다양한 연령층과 성별에 따른 생존율을 확인하자.
unstack() : MultiIndex의 피벗의 레이블을 재구성할 때 사용한다.
DataFrame의 행 인덱스를 열인덱스로 변환하는 역할을 한다.

titanic['age_group'] = pd.cut(titanic['age'], bins = [0, 18, 62, 100], labels = ['Child', 'Adult', 'Senior'])
​
titanic.groupby(['age_group', 'sex', 'survived']).size().unstack()
titanic.groupby(['age_group', 'sex', 'survived']).count()
#titanic['age_group']
#titanic.groupby(['age_group', 'sex'])
#titanic.groupby(['age_group', 'sex']).size()
#titanic.groupby(['age_group', 'sex']).size().unstack() 
#titanic.groupby(['age_group', 'sex', 'survived'])
#titanic.groupby(['age_group', 'sex', 'survived']).size()
pclass	age	sibsp	parch	fare	embarked	class	who	adult_male	deck	embark_town	alive	alone	fare_bracket	family_size
age_group	sex	survived															
Child	female	0	22	22	22	22	22	22	22	22	22	2	22	22	22	22	22
1	46	46	46	46	46	46	46	46	46	12	46	46	46	46	46
male	0	47	47	47	47	47	47	47	47	47	1	47	47	47	47	47
1	24	24	24	24	24	24	24	24	24	8	24	24	24	24	24
Adult	female	0	42	42	42	42	42	42	42	42	42	4	42	42	42	42	42
1	149	149	149	149	149	147	149	149	149	71	147	149	149	148	149
male	0	301	301	301	301	301	301	301	301	301	47	301	301	301	295	301
1	68	68	68	68	68	68	68	68	68	32	68	68	68	65	68
Senior	female	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
1	2	2	2	2	2	2	2	2	2	1	2	2	2	2	2
male	0	12	12	12	12	12	12	12	12	12	5	12	12	12	12	12
1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1

### Q13. 지불한 요금과 연령 사이에 상관관계가 있는지 확인 해보자.
corr() : 두 변수간의 선형관계를 측정하는 피어슨 상관계수를 계산하는 메소드
(통계적 유의성 : 가설검정(p)) _ 표본 대 모집단, <제1종 오류, 제2종 오류>

상황별 임계값, 통계적 유의성, 계수해석, 영역패턴 등
상관계수와 통계적 유의성을 함께 확인 후 분석할지말지 판단해야한다.
(통계적으로 유의미한 상관관계는 특정표본의 패턴보다 모집단의 실제 관계를 반영할 가능성이 더 높다.)
대각선의 요소 : 행렬의 대각선은 항상 1.0, 모든변수는 자체적으로 완벽하게 상관되어 있다.

비대각선의 요소 : 상관계수가 1에 가까우면 강한 양의 상관관계가 있다. ex) "연령이 높을수록 요금도 높다"
-1에 가까우면 강한 음의 상관 관계가 있다. ex) "연령이 높을수록 요금은 감소한다."
0 근처의 값이면 두 변수 사이에 선형관계가 없다.

강도 해석 : 상관계수의 크기는 상관 관계의 강도를 나타낸다. (-1 ~ 1)

통계적 유의성 한계 제1종 오류 = 오탐지 : 실제로 모집단에 영향이 없는 경우(오류) 통계적으로 유의미한 결과를 찾을 위험이 있다. 제2종 오류 = 거짓음성 : 모집단에 실제 효과가 있더라도 통계적으로 유의미한 결과를 찾지 못할 수 있다.

통계적으로 유의미한 결과 : 표본에서 관찰된 관계가 표본을 추출한 더 큰 모집단에 존재할 가능성이 있다. (확률근거)

제1종 오류 = 오탐지 : 실제로 모집단에 영향이 없는 경우(오류) 통계적으로 유의미한 결과를 찾을 위험이 있다.
ex) 귀무가설(효과없다, 차이없다), 대립가설(어떤효과가 있는지, 실제 차이는뭔지)

-- 약을 개발 -> 회복시간이 향상되었는지 테스트 -> 귀무가설 = 약물이 회복시간에 영향을 미치지 않는다.
-- 테스트를 실제 진행한 결과 -> 약물복용 후 회복시간이 크게 향상되었다.
-> 그런데 실제로는 약의 효과가 없고 관찰한 차이는 무작위 우연이나 실험에서 설명되지 않는 다른 요인에 의한 것이였다.
-> 실험 결과에 따라 약효가 있다고 선언하는 것은 1종 오류이다.

========> 유의수준 : 제1종 오류를 범할 확률을 알파로 표기한다. (0.05%)     
                      -> 귀무가설이 실제로 참일때 귀무가설을 기각할 확률이 5% 이다.   
titanic[['fare', 'age']].corr()
fare	age
fare	1.000000	0.096067
age	0.096067	1.000000
대각선의 요소 : (fare와 fare / age와 age) = 1
비대각선의 요소 (요금과 연령의 관계 fare 와 age) = 0.096067 -> 0에 가깝다 "요금과 연령사이에 매우 약한 양의 상관관계가 있다." => 중요하지 않거나 분석이 의미가 없다.
평가지표

생존 상태 보기(Survival Status View)에서는 성별(Gender View) 및 계층(Class View)과 같은 요인에 크게 영향을 받는 생존율의 뚜렷한 차이가 드러났다.
특히 여성과 일등석 승객의 생존율이 더 높았다.
Age Group View는 잠재적으로 구조 노력의 우선순위로 인해 어린이의 생존 가능성이 더 높다는 점을 강조했다.
특정 데크가 더 유리하다는 점을 시사했다.
형제자매/배우자 및 부모/자녀 보기를 통해 가족 규모가 생존가능성에 어떤 영향을 미치는지 엿볼 수 있고, 소규목 가족의 경우 약간 더 나은 결과를 보였다.
시각화

성별 및 계층별 생존률
연령별 생존률
가족 규모가 생존에 미치는 영향 ex) sns.parplot
# 성별 및 계층별 그래프
plt.figure(figsize = (10,5)) # 사이즈 조절
plt.subplot(1,2,1) # 줄, 칸, 위치
sns.barplot(x = 'sex', y = 'survived', data = titanic)
plt.title('Survival Rate by Gender') # 그래프 제목
​
plt.subplot(1,2,2)
sns.barplot(x = 'class', y = 'survived', data = titanic)
plt.title('Survival Rate by Class')
​
plt.show()

# 연령별 생존률
​
sns.barplot(x = 'age_group', y = 'survived', data = titanic)
plt.title('Survival Rate by Age') # 그래프 제목
plt.show()

# 가족 규모가 생존에 미치는 영향
​
sns.barplot(x = 'family_size', y = 'survived', data = titanic)
plt.title('Survival Rate by family_size') # 그래프 제목
plt.show()

기본정보 확인, 결측치 확인 후 데이터 정리
titanic.info()
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 891 entries, 0 to 890
Data columns (total 18 columns):
 #   Column        Non-Null Count  Dtype   
---  ------        --------------  -----   
 0   survived      891 non-null    int64   
 1   pclass        891 non-null    int64   
 2   sex           891 non-null    object  
 3   age           714 non-null    float64 
 4   sibsp         891 non-null    int64   
 5   parch         891 non-null    int64   
 6   fare          891 non-null    float64 
 7   embarked      889 non-null    object  
 8   class         891 non-null    category
 9   who           891 non-null    object  
 10  adult_male    891 non-null    bool    
 11  deck          203 non-null    category
 12  embark_town   889 non-null    object  
 13  alive         891 non-null    object  
 14  alone         891 non-null    bool    
 15  age_group     714 non-null    category
 16  fare_bracket  873 non-null    category
 17  family_size   891 non-null    int64   
dtypes: bool(2), category(4), float64(2), int64(5), object(5)
memory usage: 89.7+ KB
titanic.isnull().sum()
survived          0
pclass            0
sex               0
age             177
sibsp             0
parch             0
fare              0
embarked          2
class             0
who               0
adult_male        0
deck            688
embark_town       2
alive             0
alone             0
age_group       177
fare_bracket     18
family_size       0
dtype: int64
# 널값 확인 후 불필요한 값을 처리하거나 불필요한 열을 제거
# age의 널값을 median()으로 대처하자.
titanic['age'].fillna(titanic['age'].median(), inplace = True)
# 분석 및 시각화
# 생존률
sns.countplot(x = 'survived', data = titanic)
plt.show()

# 연령 분포도 histplot
sns.histplot(titanic['age'], kde = True)
plt.show()

# 상관 관계 히트맵
sns.heatmap(titanic[['fare', 'age']].corr(), annot = True, cmap = 'coolwarm')
plt.show()
