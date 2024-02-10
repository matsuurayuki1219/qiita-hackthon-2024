import { Injectable } from '@nestjs/common';
import { Praise } from 'src/models/praise/praise';
import { Reaction } from 'src/models/reaction/reaction';

@Injectable()
export class PraiseService {
  constructor() {}
  private readonly praises: Praise[] = [];

  async postPraise(praise: Omit<Praise, 'id' | 'reactions'>): Promise<Praise> {
    const prise = new Praise();
    prise.id = this.praises.length + 1;
    prise.title = praise.title;
    prise.description = praise.description;
    prise.from_user_id = praise.from_user_id;
    prise.to_user_id = praise.to_user_id;
    prise.reactions = [];
    this.praises.push(prise);
    return prise;
  }

  async getCurrentPraise(): Promise<Praise | undefined> {
    return this.praises[this.praises.length - 1];
  }

  async findById(id: number): Promise<Praise | undefined> {
    return this.praises.find((praise) => praise.id === id);
  }

  async putReaction(
    praise: Praise,
    reaction: Pick<Reaction, 'from_user_id' | 'comment' | 'emoji'>,
  ): Promise<Reaction> {
    const existReaction = praise.reactions.find(
      (reaction) => reaction.from_user_id === reaction.from_user_id,
    );
    if (existReaction) {
      existReaction.comment = reaction.comment;
      existReaction.emoji = reaction.emoji;
      return existReaction;
    }
    const newReaction = new Reaction();
    newReaction.id = praise.reactions.length + 1;
    newReaction.comment = reaction.comment;
    newReaction.emoji = reaction.emoji;
    newReaction.from_user_id = reaction.from_user_id;

    praise.reactions.push(newReaction);

    return newReaction;
  }
}
