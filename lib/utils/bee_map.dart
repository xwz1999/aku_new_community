class BeeMap {
  Map<int, String> fixTag = {
    1: '公区报修',
    2: '家庭报修',
  };

  Map<int, String> fixState = {
    1: '待分配',
    2: '未接单',
    3: '处理中',
    4: '已处理',
    5: '已完成',
    6: '已关闭',
    7: '已作废',
    8: '未知'
  };

  Map<int, String> processClass = {
    1: '报修时间',
    2: '管家分派',
    3: '师傅接单',
    4: '处理完成',
    5: '确认',
    6: '回访',
    7: '回退',
    8: '作废',
    9: '取消'
  };

  Map<int, String> goodsOutweight = {
    1: '< 50kg',
    2: '50kg-100kg',
    3: '> 100kg',
  };
  Map<int,String> goodsOutApproach={
    1:'自己搬运',
    2:'搬家公司',
  };
}
