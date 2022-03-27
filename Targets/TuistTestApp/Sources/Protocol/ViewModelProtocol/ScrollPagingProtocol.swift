
import Foundation

//Class 에서만 사용이가능하도록 AnyObject 채택
protocol ScrollPagingProtocl : AnyObject {
    
    var totalCount : Int { get set}
    var itemCount : Int { get }
  
    //페이징카운트
    var pagingCount : Int  { get set }
  
   
    func pagingCountClear()
    
    func pagingCountSetting(totalCount : Int)
    
    func pagingAbleChecking(paingAble : PagingAbleModel , totalCount : Int) -> Bool
}






extension ScrollPagingProtocl {
    

    
    func pagingCountClear(){
        self.totalCount = 0
        self.pagingCount  = 1
    }
    //요청하는 아이템의 갯수는 30개
    //최초시작
    //ex 0개 1페이지 30개 요청
    //ex 30개 1페이지 30개
    //점검
    //
    func pagingCountSetting(totalCount : Int)  {
        self.totalCount = totalCount
  
        if(!(totalCount < itemCount * pagingCount)){
            self.pagingCount += 1
        }
    }
    
    //현재 방식은 API 주는 데이터를 최대한 활용하는 방법으로 페이징 카운트를 계산하였다.
    
    
    //기존의 제가 진행 하던 다른 프로젝트에서 페이징을 컨트롤 할때는
    //N개의 데이터를 요청 -> N개의 데이터가 내려올 경우 -> 페이징카운트+ , 다음페이징요청을 컨트롤하는 Bool값을 True
    //N개의 데이터를 요청 -> N개보다 적은 데이터가 내려올경우 -> 페이징카운트유지 , 다음페이징요청을 컨트롤하는 Bool값을 False
    //예시 함수
    //    func pagingCountChecking(requestItemCount : Int)  {
    //        self.totalCount += requestItemCount
    //
    //        if(self.totalCount < self.itemCount * self.pagingCount){
    //            self.scrollPagingCall = false
    //        }else{
    //            self.pagingCount += 1
    //        }
    //    }
    
    func pagingAbleChecking(paingAble : PagingAbleModel , totalCount : Int) -> Bool {
        pagingCountSetting(totalCount: totalCount)
        return !paingAble.isEnd && paingAble.pageableCount >= totalCount
    }
    
}
