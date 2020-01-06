import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { LoginComponent } from './auth/login/login.component';
import { RegisterComponent } from './auth/register/register.component';
import { CredentialComponent } from './account/credential/credential.component';
import { FavorComponent } from './account/favor/favor.component';
import { WelcomeComponent } from './welcome/welcome.component';
import { QuestBoardComponent } from './core/quest-board/quest-board.component';


const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'quest-board' },
  { path: 'quest-board', component: QuestBoardComponent },
  { path: 'welcome', component: WelcomeComponent,  data: { title: 'My Calendar' }},
  // Authorization
  { path: 'login', component: LoginComponent },
  { path: 'register', component: RegisterComponent },
  // Account
  { path: 'credential', component: CredentialComponent },
  { path: 'favor', component: FavorComponent },
  { path: 'favor/:uid', component: FavorComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
