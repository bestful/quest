import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { QuestBoardComponent } from './quest-board.component';

describe('QuestBoardComponent', () => {
  let component: QuestBoardComponent;
  let fixture: ComponentFixture<QuestBoardComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ QuestBoardComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(QuestBoardComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
