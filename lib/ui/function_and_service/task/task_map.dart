class TaskMap {
  static Map<int, String> taskMode = {1: '大厅', 2: '我服务的', 3: '我发布的'};
  static Map<int, String> taskType = {
    1: '跑腿',
    2: '家政',
    3: '维修',
    4: '家教',
    9: '其他'
  };
  static Map<int, String> statusToString = {
    1: '已发布',
    2: '已接取',
    3: '服务中',
    4: '待确认',
    5: '已完成',
    6: '已评价',
    9: '已取消'
  };

  static Map<int, String> typeToString = {1: '跑腿', 2: '代驾', 3: '装修', 4: '陪玩'};
  static Map<int, String> serviceObject = {1: '住户', 2: '物业', 3: '不限'};

  static Map<int, String> rewardType = {1: '赏金', 2: '积分'};
}
