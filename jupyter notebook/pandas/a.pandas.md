# Jupyter Notebook
## pandas

> 데이터 탐색 및 시각화   
> 데이터 전처리 : 누락된 값, 이상치 관리, 특성 스케일링작업 (표준화, 정규화)

## pandas 명령어
- `read_csv` : CSV 파일을 DataFrame으로 읽습니다.
- `read_excel` : 엑셀 파일을 DataFrame으로 읽습니다.
- `read_json` : JSON 문자열을 DataFrame으로 읽습니다.
- `to_csv` : DataFrame을 CSV 파일로 저장합니다.
- `to_excel` : DataFrame을 엑셀 파일로 저장합니다.
- `to_json` : DataFrame을 JSON 형식으로 저장합니다.
- `head` : DataFrame의 처음 몇 행을 반환합니다.
- `tail` : DataFrame의 마지막 몇 행을 반환합니다.
- `describe` : DataFrame의 수치형 컬럼에 대한 요약 통계를 반환합니다.
- `info` : DataFrame의 요약 정보를 출력합니다.
- `shape` : DataFrame의 형태(행과 열의 수)를 반환합니다.
- `dtypes` : 각 컬럼의 데이터 타입을 반환합니다.
- `groupby` : 지정한 컬럼에 따라 데이터를 그룹화합니다.
- `merge` : 두 DataFrame을 병합합니다.
- `join` : 두 DataFrame을 인덱스 또는 컬럼으로 조인합니다.
- `concat` : 여러 DataFrame을 연결합니다.
- `pivot` : 데이터를 피벗 테이블 형태로 변형합니다.
- `pivot_table` : 피벗 테이블을 생성합니다.
- `melt` : DataFrame을 긴 형식으로 재구성합니다.
- `apply` : 함수를 DataFrame의 축(axis)에 적용합니다.
- `applymap` : 각 원소에 함수를 적용합니다.
- `agg` : 여러 집계 함수를 한 번에 적용합니다.
- `filter` : 특정 조건에 맞는 데이터를 필터링합니다.
- `map` : 시리즈(Series)의 각 원소에 함수를 적용합니다.
- `drop` : 특정 축(axis)의 항목을 삭제합니다.
- `dropna` : 결측값이 있는 행 또는 열을 제거합니다.
- `fillna` : 결측값을 특정 값으로 채웁니다.
- `isna` : 결측값 여부를 확인합니다.
- `duplicated` : 중복된 행을 확인합니다.
- `drop_duplicates` : 중복된 행을 제거합니다.
- `replace` : 특정 값을 다른 값으로 교체합니다.
- `sort_values` : 특정 컬럼에 따라 데이터를 정렬합니다.
- `sort_index` : 인덱스에 따라 데이터를 정렬합니다.
- `reset_index` : 인덱스를 초기화합니다.
- `set_index` : 특정 컬럼을 인덱스로 설정합니다.
- `rank` : 데이터의 순위를 매깁니다.
- `sample` : 임의의 행을 추출합니다.
- `copy` : DataFrame의 복사본을 생성합니다.
- `astype` : 데이터 타입을 변경합니다.
- `clip` : 값의 범위를 제한합니다.
- `nlargest` : 가장 큰 N개의 값이 있는 행을 반환합니다.
- `nsmallest` : 가장 작은 N개의 값이 있는 행을 반환합니다.
- `idxmax` : 최대값을 가진 인덱스를 반환합니다.
- `idxmin` : 최소값을 가진 인덱스를 반환합니다.
- `explode` : 리스트 형태의 컬럼을 여러 행으로 확장합니다.
- `to_dict` : DataFrame을 딕셔너리로 변환합니다.
- `to_sql` : DataFrame을 SQL 데이터베이스 테이블로 저장합니다.
- `to_numpy` : DataFrame을 NumPy 배열로 변환합니다.
- `to_markdown` : DataFrame을 마크다운 테이블 형식으로 변환합니다.
- `to_html` : DataFrame을 HTML 테이블로 변환합니다.

### 탐색적 데이터 분석 (EDA : Exploratory Data Analysis) : 데이터 특성 확인

- 기본 정보 확인 : 데이터의 크기, 변수의 타입, 결측치 유무 등을 확인
- 기술 통계 확인 : 각 변수의 중심 경향(평균, 중앙값 등), 분포(표준편차, 최소/최대찺 등)을 호가인
- 클래스 분포 확인 : 타겟 변수(여기서는 붓꽃의 종류)의 분포를 확인
- 변수 간 관계 확인 : 변수들 간의 관계를 시각화하고 상관관계를 분석

> 데이터로드 -> EDA, 시각화 -> 전처리(이상치관리, 특성스케일[표준화,정규화] -> 모델구축 -> 평가 및 검증 -> 결과해석 보고)

### Series객체
> 리턴을 컬럼과 인덱스형식으로 한다.
