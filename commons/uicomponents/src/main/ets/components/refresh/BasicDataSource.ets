/**
 * onDataReloaded：通知组件重新加载所有数据。键值没有变化的数据项会使用原先的子组件，键值发生变化的会重建子组件。重新加载数据完成后调用
 * onDataAdd：通知组件index的位置有数据添加。添加数据完成后调用
 * onDataMove(from: number, to: number)：通知组件数据有移动。将from和to位置的数据进行交换。数据移动起始位置与数据移动目标位置交换完成后调用。
 * onDataDelete：通知组件删除index位置的数据并刷新LazyForEach的展示内容。删除数据完成后调用
 * onDataChange(index: number): void 通知组件index的位置有数据有变化。改变数据完成后调用。
 * onDatasetChange(dataOperations: DataOperation[])：进行批量的数据处理，该接口不可与上述接口混用。批量数据处理后调用
 *    DataOperation：
 *        DataAddOperation：添加数据操作。
 *        DataDeleteOperation：删除数据操作。
 *        DataChangeOperation：改变数据操作。
 *        DataMoveOperation：移动数据操作
 *        DataExchangeOperation：交换数据操作。
 *        DataReloadOperation：重载所有数据操作。当onDatasetChange含有DataOperationType.RELOAD操作时，其余操作全部失效，框架会自己调用keygenerator进行键值比对
 *
 *        DataOperationType
 *        属性         值            说明
 *        ADD         add    ·     数据添加
 *        DELETE      delete       数据删除
 *        CHANGE      change       数据改变
 *        MOVE        move         数据移动
 *        EXCHANGE    exchange     数据交换
 *        RELOAD      reload       全部数据重载
 */
import { PullStatus, RefreshController } from '@zhongrui/pull_to_refresh_v2';

export class BasicDataSource<T> implements IDataSource {
  private listeners: DataChangeListener[] = [];
  private originDataArray: T[] = [];

  public totalCount(): number {
    return 0;
  }

  public getData(index: number): T {
    return this.originDataArray[index];
  }

  // 系统调用，开发不用关心
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener);
    }
  }

  // 系统调用，开发不用关心
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      this.listeners.splice(pos, 1);
    }
  }

  // 通知LazyForEach组件需要重载所有子组件，这个有可能闪烁
  // 用 onDatasetChange 代替onDataReloaded，不仅可以修复闪屏的问题，还能提升加载性能
  // https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkts-rendering-control-lazyforeach-V5
  // 通知组件重新加载所有数据。键值没有变化的数据项会使用原先的子组件，键值发生变化的会重建子组件。重新加载数据完成后调用。
  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDatasetChange([{ type: DataOperationType.RELOAD }]);
    })
  }

  notifyDatasetChange(operations: DataOperation[]): void {
    this.listeners.forEach(listener => {
      listener.onDatasetChange(operations);
    })
  }
}

export class BaseDataSource<T> extends BasicDataSource<T> {
  private dataArray: T[] = [];

  public totalCount(): number {
    return this.dataArray.length;
  }

  /**
   * 获取数据
   * @param index
   * @returns
   */
  public getData(index: number): T {
    return this.dataArray[index];
  }

  /**
   * 删除 index 下的数组，如果 index 大于或者等于 ，则不删除，也不添加
   * @param index
   * @returns 是否成功
   */
  public deleteData(index: number): boolean {
    if (this.dataArray.length > index) {
      this.dataArray.splice(index, 1);
      this.notifyDatasetChange([
        { type: DataOperationType.DELETE, index: index }
      ])
      return true;
    }
    console.warn(`deleteData 当前的index=${index} 已经大于或者等于 数组的length=${this.dataArray.length}`)
    return false;
  }

  /**
   * 移动数据，如果 from to 大于或者等于 则不移动
   * @param from 要移动的index
   * @param to 要移动到的目标index
   * @returns 是否成功
   */
  public moveData(from: number, to: number): boolean {
    if (this.dataArray.length > from && this.dataArray.length > to) {
      this.notifyDatasetChange([
        { type: DataOperationType.MOVE, index: { from: from, to: to } }
      ])
      return true
    }
    console.warn(`moveData 当前的from=${from} to=${to} 已经大于或者等于 数组的length=${this.dataArray.length}`)
    return false
  }

  /**
   * 向数组末尾添加一个元素
   */
  public addData(data: T, index?: number): void {
    if (index) {
      this.addIndexData(index, data);
    } else {
      this.dataArray.push(data);
      this.notifyDatasetChange([
        { type: DataOperationType.ADD, index: this.dataArray.length - 1 }])
    }
  }

  /**
   * 通知单个item更改,如果 大于或者等于 数组的length 就不操作
   * 一般也不需要这个，如果是新的数据，那么相当于重新设置了数据，里面的图片会闪一下
   * 可以使用 @Observed 和 @ObjectLink 配合使用去更新数据，避免闪烁
   * @param index
   * @param data
   * @returns 是否成功
   */
  public notifyItemChange(index: number, data: T): boolean {
    // 是否需要这样，这个的本意就是通知当前item改变了
    if (this.dataArray.length > index) {
      // 但是如果没有这个index ，这里会增加
      this.dataArray.splice(index, 1, data);
      this.notifyDatasetChange([
        { type: DataOperationType.CHANGE, index: index }])
      return true;
    }
    console.warn(`notifyItemChange 当前的index=${index} 已经大于或者等于 数组的length=${this.dataArray.length}`)
    return false;
  }

  /**
   * 在末尾添加一个数组
   * @param data
   */
  public addAllData(data: Array<T>): void {
    const totalCount = this.dataArray.length;
    this.dataArray.push(...data);
    this.notifyDatasetChange([
      { type: DataOperationType.ADD, index: totalCount, count: data.length }])
  }

  /**
   * 添加全新的数据，也就是清空原有的数据，添加新的数组
   * @param data
   */
  public setNewData(data: Array<T>) {
    let oldLength = this.dataArray.length
    this.dataArray.splice(0, this.dataArray.length);
    this.dataArray.push(...data)
    this.notifyDatasetChange([
    // 这样可以服用以前的数据，比如 setNewData 两次同样的数据，如果不加这个会闪烁
    // delete 和 add 最好加上，否则在grid里面会有问题
      { type: DataOperationType.DELETE, index: 0, count: oldLength },
      { type: DataOperationType.ADD, index: 0, count: data.length },
      { type: DataOperationType.RELOAD },
    ])
  }

  /**
   * 列表页数 处理
   * @param success  成功失败标识
   * @param page     页数
   * @param total    总条数
   * @param data     数据
   * @param controller RefreshController
   * @param pageNums 返回的page
   */
  public pageRefresh(success: boolean, page: number, total: number, data: Array<T>, controller: RefreshController, pageNums: (pages: number) => void) {
    if (success) {
      if (page == 1) {
        this.setNewData(data)
        controller.refreshSuccess()
        pageNums(2)

        if (this.totalCount() == 0) {
          controller.viewEmpty()
        }
      } else {
        this.addAllData(data)
        controller.loadSuccess()
        pageNums(data.length == 0 ? page : (page + 1))
      }
      // 是否还有更多
      setTimeout(() => {
        controller.hasMore(this.totalCount() < total /*|| !(data.length < 10)*/)
      }, 800) //处理暂无更多数据视图和列表同时显示出来


    } else {
      if (controller.getStatus() == PullStatus.Refresh) {
        controller.refreshError()
      } else {
        controller.loadError()
      }
      if (page == 1) {
        controller.viewError()
      }
    }

  }

  private addIndexData(index: number, data: T): void {
    if (this.dataArray.length >= index) {
      this.dataArray.splice(index, 0, data);
      this.notifyDatasetChange([
        { type: DataOperationType.ADD, index: index }])
    } else {
      console.warn(`addData 当前的index=${index} 已经大于 数组的length=${this.dataArray.length}`)
    }
  }
}
